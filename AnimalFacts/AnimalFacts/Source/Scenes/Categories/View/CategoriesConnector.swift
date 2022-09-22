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
      categories: graph.categories.models.map(\.id),
      row: { CategoryConnector(id: $0) },
      facts: { FactsConnector() },
      onSelect: Command { _ in
        // TODO: Dispatch action
      }
    )
  }
}
