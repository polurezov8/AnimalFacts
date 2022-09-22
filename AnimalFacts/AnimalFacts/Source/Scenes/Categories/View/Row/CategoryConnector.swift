//
//  CategoryConnector.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct CategoryConnector: Connector {
  let id: CategoryModel.ID

  func map(graph: Graph) -> some View {
    let model = graph.categories.categorie(for: id)
    return CategoryView(
      title: model.title,
      subtitle: model.subtitle,
      image: Mock.Image.dog, // TODO: Add image loading and caching
      isPremium: model.isPremium,
      overlay: {
        model.isAvailable ? nil : UnavailableView()
      }
    )
  }
}
