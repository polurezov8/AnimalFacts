//
//  FactsView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct FactsView<Fact: View>: View {
  let navigationTitle: String
  let models: [FactModel]
  let factView: (FactModel.ID, Command<Void>?, Command<Void>?) -> Fact
  @State var model: CardStackModel<FactModel>

  var body: some View {
    NavigationView {
      ZStack {
        Colors.background
          .ignoresSafeArea()
        CardStack(model: model) { element in
          factView(
            element.id,
            model.isFirst ? nil : Command {
              withAnimation(.interpolatingSpring(
                stiffness: Constants.animationStiffness,
                damping: Constants.animationDamping
              )) { model.unswipe() }
            },
            model.isLast ? nil : Command {
              withAnimation(.interpolatingSpring(
                stiffness: Constants.animationStiffness,
                damping: Constants.animationDamping
              )) { model.swipe() }
            }
          )
        }
        .padding(.top, 48)
      }
    }
    .navigationTitle(navigationTitle)
    .navigationBarTitleTextColor(.black)
  }
}

struct FactsView_Previews: PreviewProvider {
  static var previews: some View {
    FactsView(
      navigationTitle: Mock.String.title,
      models: .empty,
      factView: { _, _, _ in
        FactView(
          image: Mock.Image.dog,
          factText: Mock.String.fact,
          previousAction: .nop(),
          nextAction: .nop()
        )
      },
      model: CardStackModel<FactModel>(.empty)
    )
  }
}
