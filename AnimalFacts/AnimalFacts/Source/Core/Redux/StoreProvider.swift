//
//  StoreProvider.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct StoreProvider<Content: View>: View {
  let store: Store
  let content: () -> Content

  var body: some View {
    content().environmentObject(EnvironmentStore(store: store))
  }
}
