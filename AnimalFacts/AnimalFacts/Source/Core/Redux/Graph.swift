//
//  Graph.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

struct Graph {
  init(state: AppState, dispatch: @escaping ReduxDispatch) {
    self.state = state
    self.dispatch = dispatch
  }

  let state: AppState
  let dispatch: ReduxDispatch

  var categories: GraphCategories { GraphCategories(graph: self) }
  var facts: GraphFacts { GraphFacts(graph: self) }
}
