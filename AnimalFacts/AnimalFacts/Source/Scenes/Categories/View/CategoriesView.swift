//
//  CategoriesView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct CategoriesView<CategorieView: View, FactsView: View>: View {
  var categories: [CategoryModel.ID]
  let row: (CategoryModel.ID) -> CategorieView
  let facts: () -> FactsView
  let onSelect: Command<CategoryModel.ID>
  @State private var path: [Destination] = .empty

  var body: some View {
    NavigationStack {
      ZStack {
        Color.purple
          .ignoresSafeArea()
        List {
          ForEach(categories, id: \.self) { id in
            NavigationStack(path: $path) {
              Button(
                action: {
                  onSelect.perform(id)
                  path.append(.facts)
                },
                label: { row(id) }
              )
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 100)
            .navigationDestination(for: Destination.self) {
              switch $0 {
              case .facts: facts()
              }
            }
          }
          .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
      }
    }
    .accentColor(.black)
  }
}

extension CategoriesView {
  enum Destination: Hashable {
    case facts
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
      }, facts: {
        FactsConnector()
      },
      onSelect: .nop()
    )
  }
}
