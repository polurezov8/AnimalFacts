//
//  NetworkTarget.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

protocol NetworkTarget {
  typealias Request<T: Decodable> = Client.Request<T>
  typealias Response<T: Decodable> = Client.Response<T>
  typealias Operation = NetworkOperator.Operation
  typealias Completion<T: Decodable> = (Response<T>) -> Action
  typealias VoidCompletion = (Result<Void, Error>) -> Action

  func fire<T: Decodable>(
    uuid: RequestId,
    request: Client.Request<T>,
    dispatch: @escaping ReduxDispatch,
    onComplete: @escaping Completion<T>
  ) -> Operation

  func map(state: AppState, client: Client, dispatch: @escaping ReduxDispatch) -> [Operation]
}

extension NetworkTarget {
  func fire<T: Decodable>(
    uuid: RequestId,
    request: Request<T>,
    dispatch: @escaping ReduxDispatch,
    onComplete: @escaping Completion<T>
  ) -> Operation {
    Operation(
      uuid: uuid,
      request: request.urlRequest,
      handler: { data, response, error in
        let result = request.handler(data, response, error)
        let action = onComplete(result)
        dispatch(action)
      }
    )
  }
}
