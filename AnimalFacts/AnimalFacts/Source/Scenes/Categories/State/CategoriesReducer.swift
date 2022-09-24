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

    case is CategoriesAction.ShowAd:
      isShowingAd = true

    case is CategoriesAction.HideAd:
      isShowingAd = false

    default:
      break
    }
  }
}
