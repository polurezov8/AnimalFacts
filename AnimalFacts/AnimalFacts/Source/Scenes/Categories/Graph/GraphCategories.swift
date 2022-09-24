//
//  GraphCategories.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct GraphCategories {
  let graph: Graph

  var categoriesState: CategoriesState { graph.state.categories }
  var requestId: RequestId? { categoriesState.loadRequestId }
  var models: [CategoryModel] { categoriesState.models }
  var isLoading: Bool { categoriesState.fetchRequestId != nil || categoriesState.loadRequestId != nil }
  var isShowingAd: Bool { categoriesState.isShowingAd }

  func facts(for categoryId: CategoryModel.ID) -> [FactModel]? {
    models.first(where: { $0.id == categoryId })?.content
  }

  func categorie(for id: CategoryModel.ID) -> GraphCategory? {
    GraphCategory(graph: graph, id: id)
  }

  func alertType(for id: CategoryModel.ID) -> CategoriesAlertType? {
    guard let model = GraphCategory(graph: graph, id: id) else { return nil }
    if model.isUnavailable { return .unavailable }
    if model.isPremium { return .paid }
    return nil
  }
}

struct GraphCategory {
  @Environment(\.imageCache) var imageCache

  let graph: Graph
  let id: CategoryModel.ID
  let model: CategoryModel

  init?(graph: Graph, id: CategoryModel.ID) {
    guard let model = graph.categories.models.first(where: { $0.id == id }) else {
      return nil
    }

    self.graph = graph
    self.id = id
    self.model = model
  }

  var title: String { model.title }
  var subtitle: String { model.description }
  var image: UIImage { imageCache.image(for: .category(model.id)) }
  var isPremium: Bool { model.status == .paid }
  var isAvailable: Bool { !model.content.isEmptyOrNil }
  var isUnavailable: Bool { !isAvailable }
}

extension Optional where Wrapped: Collection {
  var isEmptyOrNil: Bool { self?.isEmpty ?? true }
}
