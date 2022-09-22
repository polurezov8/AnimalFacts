//
//  CategoriesTarget.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

struct CategoriesTarget: NetworkTarget {
  typealias Operation = NetworkOperator.Operation

  func map(state: AppState, client: Client, dispatch: @escaping ReduxDispatch) -> [Operation] {
    var operations: [Operation] = .empty

    if let requestId = state.categories.requestId {
      let request = client.getCategories(id: requestId)
      let operation = fire(
        uuid: requestId,
        request: request,
        dispatch: dispatch
      ) { response in
        switch response {
        case let .success(models):
          return CategoriesAction.Loaded(models: models)
        default:
          return CategoriesAction.LoadFailed()
        }
      }

      operations.append(operation)
    }

    return operations
  }
}
