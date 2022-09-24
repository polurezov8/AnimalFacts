//
//  FactConnector.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct FactConnector: Connector {
  @Environment(\.imageCache) var imageCache

  let id: FactModel.ID
  let previousAction: Command<Void>?
  let nextAction: Command<Void>

  func map(graph: Graph) -> some View {
    guard let model = graph.facts.model(for: id) else { return FactView.empty }

    return FactView(
      image: imageCache.image(for: .fact(id)),
      factText: model.fact,
      previousAction: previousAction,
      nextAction: nextAction
    )
  }
}
