//
//  FactsReducer.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

extension FactsState {
  mutating func reduce(_ action: Action) {
    switch action {
    case let action as FactsAction.Begin:
      category = action.category
      models = action.models

    default:
      break
    }
  }
}
