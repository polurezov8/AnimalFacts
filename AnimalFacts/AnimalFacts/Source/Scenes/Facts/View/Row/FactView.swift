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
  let previousAction: Command<Void>?
  let nextAction: Command<Void>

  var body: some View {
    GeometryReader { geometry in
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
            .fixedSize(horizontal: false, vertical: true)
          Spacer()
          HStack {
            if previousAction != nil {
              Button(action: { previousAction?.perform() }) {
                Image(uiImage: Images.back)
              }
            }
            Spacer()
            Button(action: { nextAction.perform() }) {
              Image(uiImage: Images.next)
            }
          }
        }
        .padding()
      }
      .frame(height: geometry.size.height * 0.7)
    }
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
