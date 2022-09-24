//
//  StorageDriver.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import Foundation

struct StorageDriver: SideEffectsDriver {
  typealias Operator = StorageOperator
  typealias Operation = Operator.Operation
  typealias WriteOperation = Operator.WriteCategories
  typealias FetchOperation = Operator.FetchCategories

  let store: Store
  let `operator`: Operator

  func subscribe(_ component: Operator) -> Observer<AppState> {
    Observer(queue: self.operator.queue) { state in
      component.props = map(state: state)
      return .active
    }
  }

  func map(state: AppState) -> Props {
    var operations = [Operation]()

    if let writeOperationId = state.categories.writeRequestId {
      let operation = WriteOperation(
        uuid: writeOperationId.value,
        models: state.categories.models,
        onComplete: Command { result in
          switch result {
          case .success:
            dispatch.perform(CategoriesAction.WriteSucceeded())
          case .failure:
            dispatch.perform(CategoriesAction.WriteFailed())
          }
        }
      )

      operations.append(operation)
    }

    if let fetchOperationId = state.categories.fetchRequestId {
      let operation = FetchOperation(
        uuid: fetchOperationId.value,
        onComplete: Command { result in
          switch result {
          case let .success(models):
            dispatch.perform(CategoriesAction.Fetched(models: models))
          case .failure:
            dispatch.perform(CategoriesAction.FetchFailed())
          }
        }
      )

      operations.append(operation)
    }

    return operations
  }
}
