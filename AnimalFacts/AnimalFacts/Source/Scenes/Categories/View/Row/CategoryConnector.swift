//
//  CategoryConnector.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct CategoryConnector: Connector {
  @Environment(\.imageCache) var imageCache

  let id: CategoryModel.ID

  func map(graph: Graph) -> some View {
    let model = graph.categories.categorie(for: id)
    return CategoryView(
      title: model.title,
      subtitle: model.subtitle,
      image: imageCache.image(for: .category(id)),
      isPremium: model.isPremium,
      overlay: {
        model.isAvailable ? nil : UnavailableView()
      }
    )
  }
}
