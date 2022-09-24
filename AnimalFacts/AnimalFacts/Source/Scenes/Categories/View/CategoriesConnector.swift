//
//  CategoriesConnector.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct CategoriesConnector: Connector {
  func map(graph: Graph) -> some View {
    CategoriesView(
      isLoading: graph.categories.isLoading,
      categories: graph.categories.models.map(\.id),
      row: { CategoryConnector(id: $0) },
      facts: { FactsConnector() },
      alertType: { graph.categories.alertType(for: $0) },
      onSelect: Command {
        guard let facts = graph.categories.facts(for: $0) else { return }
        graph.dispatch(FactsAction.Begin(category: $0, models: facts))
      },
      onShowAd: Command { graph.dispatch(CategoriesAction.ShowAd()) },
      onHideAd: Command { graph.dispatch(CategoriesAction.HideAd()) }
    )
  }
}
