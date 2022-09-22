//
//  NetworkOperator.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

final class NetworkOperator: SideEffectsOperator {
  typealias WorkItem = URLSessionDataTask
  typealias Props = [Operation]

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

  let queue = DispatchQueue(label: DispatchQueueLabels.network.label)
  private let session = URLSession(configuration: .default)
  private var active: [RequestId: (operation: Operation, work: WorkItem)] = .empty
  private var completed: Set<RequestId> = .empty

  private func process(operation: Operation) {
    guard !completed.contains(operation.uuid) else { return }

    if active.keys.contains(operation.uuid) {
      active[operation.uuid]!.operation = operation
    } else {
      var workItem: URLSessionDataTask?
      workItem = session.dataTask(with: operation.request) { [weak self] data, response, error in
        if workItem?.state == .canceling { return }
        self?.queue.async {
          self?.complete(uuid: operation.uuid, data: data, response: response, error: error)
        }
      }

      guard let execute = workItem else { preconditionFailure() }
      active[operation.uuid] = (operation, execute)
      execute.resume()
    }
  }

  private func complete(uuid: RequestId, data: Data?, response: URLResponse?, error: Error?) {
    guard let (operation, _) = active[uuid] else { return }

    active[uuid] = nil
    completed.insert(uuid)
    operation.handler(data, response, error)
  }

  private func cancel(uuid: RequestId) {
    guard let (_, workItem) = active[uuid] else { preconditionFailure("Operation not found") }
    workItem.cancel()
    active[uuid] = nil
    completed.insert(uuid)
  }
}

extension NetworkOperator {
  struct Operation {
    let uuid: RequestId
    let request: URLRequest
    let handler: (Data?, URLResponse?, Error?) -> Void
  }
}
