//
//  Connector.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

protocol Connector: View {
  associatedtype Content: View
  func map(graph: Graph) -> Content
}

extension Connector {
  var body: some View {
    Connected<Content>(map: self.map)
  }
}

private struct Connected<V: View>: View {
  @EnvironmentObject var store: EnvironmentStore

  let map: (Graph) -> V

  var body: V {
    map(store.graph)
  }
}
