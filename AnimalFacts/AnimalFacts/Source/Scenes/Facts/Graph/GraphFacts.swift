//
//  GraphFacts.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

struct GraphFacts {
  let graph: Graph

  var title: String {
    graph.state.categories.models.first(where: { $0.id == graph.state.facts.category })?.title ?? .empty
  }

  var models: [FactModel] { graph.state.facts.models }

  func model(for id: FactModel.ID) -> FactModel? {
    models.first(where: { $0.id == id })
  }
}
