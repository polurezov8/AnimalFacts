//
//  FactsView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct FactsView<Fact: View>: View {
  let navigationTitle: String
  let factView: (FactModel.ID, Command<Void>, Command<Void>) -> Fact

  var body: some View {
    NavigationView {
      ZStack {
        Color.purple
          .ignoresSafeArea()
      }
    }
    .navigationTitle(navigationTitle)
  }
}

struct FactsView_Previews: PreviewProvider {
  static var previews: some View {
    FactsView(
      navigationTitle: Mock.String.title,
      factView: { _, _, _ in
        FactView(
          image: Mock.Image.dog,
          factText: Mock.String.fact,
          previousAction: .nop(),
          nextAction: .nop()
        )
      }
    )
  }
}
