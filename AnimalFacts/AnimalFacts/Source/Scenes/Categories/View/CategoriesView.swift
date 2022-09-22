//
//  CategoriesView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct CategoriesView<CategoryView: View>: View {
  var categories: [CategoryModel.ID]
  let row: (CategoryModel.ID) -> CategoryView
  let onSelect: Command<CategoryModel.ID>

  var body: some View {
    NavigationStack {
      ZStack {
        Color.purple
          .ignoresSafeArea()
      }
    }
  }
}

struct CategoriesView_Previews: PreviewProvider {
  static var previews: some View {
    CategoriesView(
      categories: [
        CategoryModel.ID(value: UUID()),
        CategoryModel.ID(value: UUID())
      ],
      row: { _ in
        CategoryView(
          title: Mock.String.title,
          subtitle: Mock.String.subtitle,
          image: Mock.Image.dog,
          isPremium: true,
          overlay: { nil }
        )
      },
      onSelect: .nop()
    )
  }
}
