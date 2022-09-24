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
      fetchRequestId = .new()

    case let action as CategoriesAction.Fetched:
      fetchRequestId = nil
      models = action.models
      loadRequestId = action.models.isEmpty ? .new() : nil

    case is CategoriesAction.FetchFailed:
      loadRequestId = .new()

    case let action as CategoriesAction.Loaded:
      loadRequestId = nil
      models = action.models
      writeRequestId = action.models.isEmpty ? nil : .new()

    case is CategoriesAction.LoadFailed:
      loadRequestId = nil

    case is CategoriesAction.WriteSucceeded,
      is CategoriesAction.WriteFailed:
      writeRequestId = nil

    case is CategoriesAction.ShowAd:
      isShowingAd = true

    case is CategoriesAction.HideAd:
      isShowingAd = false

    default:
      break
    }
  }
}
