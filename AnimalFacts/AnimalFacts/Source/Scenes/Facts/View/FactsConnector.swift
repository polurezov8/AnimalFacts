//
//  FactsConnector.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct FactsConnector: Connector {
  func map(graph: Graph) -> some View {
    FactsView(
      navigationTitle: graph.facts.title,
      models: graph.facts.models,
      factView: { id, previousAction, nextAction in
        FactConnector(id: id, previousAction: previousAction, nextAction: nextAction)
      },
      model: CardStackModel<FactModel>(graph.facts.models)
    )
  }
}
