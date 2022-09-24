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
    GeometryReader { geometry in
      ZStack {
        Color.white
        HStack {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding([.bottom, .top], 5)
            .padding(.leading, 10)
            .frame(width: geometry.size.width * 0.3)
          VStack(alignment: .leading) {
            VStack(alignment: .leading) {
              Text(title)
                .lineLimit(1)
                .font(.system(size: 16))
              Text(subtitle)
                .lineLimit(2)
                .font(.system(size: 12))
                .foregroundColor(.black.opacity(0.5))
                .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.top, 10)
            .padding(.leading, 12)
            Spacer()
            if isPremium {
              HStack {
                Image(uiImage: Images.lock)
                Text("Premium")
                  .foregroundColor(Colors.oceanBlue)
              }
              .padding([.leading, .bottom], 8)
            }
          }
          Spacer()
        }
        overlay()
      }
    }
    .shadow(radius: 4)
    .frame(width: UIScreen.main.bounds.width - 40, height: 100)
    .cornerRadius(6)
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

extension CategoryView: Emptyable {
  static var empty = CategoryView(
    title: Mock.String.title,
    subtitle: Mock.String.subtitle,
    image: Mock.Image.dog,
    isPremium: false,
    overlay: { nil }
  )
}
