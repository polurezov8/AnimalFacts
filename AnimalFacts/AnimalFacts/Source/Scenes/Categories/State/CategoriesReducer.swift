//
//  CategoriesReducer.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

extension CategoriesState {
  mutating func reduce(_ action: Action) {
    switch action {
    case is CategoriesAction.Begin:
      requestId = .new()

    case let action as CategoriesAction.Loaded:
      requestId = nil
      models = action.models

    default:
      break
    }
  }
}
