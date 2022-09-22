//
//  FactConnector.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct FactConnector: Connector {
  let id: FactModel.ID
  let previousAction: Command<Void>
  let nextAction: Command<Void>

  func map(graph: Graph) -> some View {
    return FactView(
      image: Mock.Image.dog, // TODO: Add image
      factText: Mock.String.fact,
      previousAction: previousAction,
      nextAction: nextAction
    )
  }
}
