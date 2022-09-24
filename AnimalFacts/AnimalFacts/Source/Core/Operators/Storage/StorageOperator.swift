//
//  StorageOperator.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import Foundation
import RealmSwift

protocol RealmTask {
  var uuid: UUID { get }
}

final class StorageOperator: SideEffectsOperator {
  typealias Operation = RealmTask
  typealias Props = [Operation]
  typealias WorkItem = DispatchWorkItem

  let queue = DispatchQueue(label: DispatchQueueLabels.storage.rawValue)
  private var active: [UUID: (operation: Operation, work: WorkItem)] = .empty
  private var completed: Set<UUID> = .empty

  var props: Props = [] {
    didSet {
      var remainedActiveIds = Set(active.keys)

      for operation in props {
        process(operation: operation)
        remainedActiveIds.remove(operation.uuid)
      }

      for cancelled in remainedActiveIds {
        cancel(uuid: cancelled)
      }
    }
  }

  private func process(operation: Operation) {
    guard !completed.contains(operation.uuid) else { return }
    // Update request to its latest version
    if active.keys.contains(operation.uuid) {
      active[operation.uuid]!.operation = operation
    } else {
      var workItem: DispatchWorkItem? {
        switch operation {
        case let operation as WriteCategories:
          return writeCategories(operation)
        case let operation as FetchCategories:
          return fetchCategories(operation)
        default:
          preconditionFailure("Unknown Realm Task")
        }
      }

      guard let toExecute = workItem else { preconditionFailure("DispatchWorkItem is nil") }
      // Store it to list of active tasks
      active[operation.uuid] = (operation, toExecute)
      // Begin task execution
      queue.async(execute: toExecute)
    }
  }

  private func cancel(uuid: UUID) {
    guard let (_, work) = active[uuid] else {
      preconditionFailure("Operation not found")
    }

    work.cancel() // Stop task execution
    active[uuid] = nil
    completed.insert(uuid)
  }

  private func complete<ResultType>(
    _ operation: Operation,
    _ onComplete: Command<ResultType>,
    _ result: ResultType
  ) {
    guard let (operation, _) = active[operation.uuid] else {
      preconditionFailure("Operation not found")
    }

    active[operation.uuid] = nil
    onComplete.perform(result)
    completed.insert(operation.uuid)
  }
}

// MARK: - Write categories oepration

extension StorageOperator {
  struct WriteCategories: Operation {
    let uuid: UUID
    let models: [CategoryModel]
    let onComplete: Command<Result<Void, Error>>
  }

  func writeCategories(_ operation: WriteCategories) -> DispatchWorkItem? {
    var workItem: DispatchWorkItem?
    workItem = DispatchWorkItem { [weak self] in
      do {
        if workItem?.isCancelled ?? true { return }
        let realm = try Realm()
        let objects = operation.models.map { StorageCategoryModel(model: $0) }
        try realm.write {
          realm.add(objects)
        }
        self?.complete(operation, operation.onComplete, .success)
      } catch {
        self?.complete(operation, operation.onComplete, .failure(error))
      }
    }
    return workItem
  }
}

// MARK: Fetch categories operation

extension StorageOperator {
  struct FetchCategories: Operation {
    let uuid: UUID
    let onComplete: Command<Result<[CategoryModel], Error>>
  }

  func fetchCategories(_ operation: FetchCategories) -> DispatchWorkItem? {
    var workItem: DispatchWorkItem?
    workItem = DispatchWorkItem { [weak self] in
      if workItem?.isCancelled ?? true { return }
      do {
        let realm = try Realm()
        let objects = realm.objects(StorageCategoryModel.self)
        let items = Array(objects.map { $0.mapToModel() })
        self?.complete(operation, operation.onComplete, .success(items))
      } catch {
        self?.complete(operation, operation.onComplete, .failure(error))
      }
    }
    return workItem
  }
}

extension Result where Success == Void {
  static var success: Result { .success(()) }
}
