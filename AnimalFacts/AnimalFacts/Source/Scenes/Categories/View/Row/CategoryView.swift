//
//  CategoryView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct CategoryView: View {
  let title: String
  let subtitle: String
  let image: UIImage
  let isPremium: Bool
  let overlay: () -> UnavailableView?

  var body: some View {
    ZStack {
      Color.white
      HStack {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: UIScreen.main.bounds.width / 4)
          .padding([.leading, .bottom, .top], 8)
          .cornerRadius(4)
        VStack(alignment: .leading) {
          VStack {
            Text(title)
              .multilineTextAlignment(.leading)
            Text(subtitle)
              .multilineTextAlignment(.leading)
          }
          .scaledToFit()
          Spacer()
          if isPremium {
            HStack {
              Image(systemName: "lock")
              Text("Premium")
            }
          }
        }
        Spacer()
      }
      overlay()
    }
    .cornerRadius(32)
    .shadow(radius: 8)
  }
}

struct CategorieView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CategoryView(
        title: Mock.String.title,
        subtitle: Mock.String.subtitle,
        image: Mock.Image.dog,
        isPremium: true,
        overlay: { UnavailableView() }
      )
    }
  }
}
