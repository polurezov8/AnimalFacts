//
//  GraphCategories.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

struct GraphCategories {
  let graph: Graph

  var requestId: RequestId? { graph.state.categories.requestId }
  var models: [CategoryModel] { graph.state.categories.models }

  func facts(for categoryId: CategoryModel.ID) -> [FactModel]? {
    models.first(where: { $0.id == categoryId })?.content
  }

  func categorie(for id: CategoryModel.ID) -> GraphCategory {
    GraphCategory(graph: graph, id: id)
  }
}

struct GraphCategory {
  let graph: Graph
  let id: CategoryModel.ID

  // TOOD: Optional init

  var model: CategoryModel { graph.categories.models.first(where: { $0.id == id })! }
  var title: String { model.title }
  var subtitle: String { model.description }
//  var image: UIImage { } // TODO
  var isPremium: Bool { model.status == .paid }
  var isAvailable: Bool { !model.content.isEmptyOrNil }
}

extension Optional where Wrapped: Collection {
  var isEmptyOrNil: Bool { self?.isEmpty ?? true }
}
