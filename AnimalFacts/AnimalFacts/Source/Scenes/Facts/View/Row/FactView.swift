//
//  FactView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct FactView: View {
  let image: UIImage
  let factText: String
  let previousAction: Command<Void>
  let nextAction: Command<Void>

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .foregroundColor(.white)
        .clipped()
        .shadow(radius: 8)
      VStack {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(height: 148)
        Text(factText)
          .padding()
        HStack {
          Button(action: { previousAction.perform() }) {
            Text("Previous")
          }
          Spacer()
          Button(action: { nextAction.perform() }) {
            Text("Next")
          }
        }
      }
      .padding()
    }
    .fixedSize(horizontal: false, vertical: true)
    .padding()
  }
}

struct FactView_Previews: PreviewProvider {
  static var previews: some View {
    FactView(
      image: Mock.Image.dog,
      factText: Mock.String.fact,
      previousAction: .nop(),
      nextAction: .nop()
    )
  }
}

extension FactView: Emptyable {
  static var empty: Self {
    FactView(
      image: Mock.Image.dog,
      factText: .empty,
      previousAction: .nop(),
      nextAction: .nop()
    )
  }
}
