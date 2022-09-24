//
//  CategoriesView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

struct CategoriesView<CategorieView: View, FactsView: View>: View {
  var isLoading: Bool
  let categories: [CategoryModel.ID]
  let row: (CategoryModel.ID) -> CategorieView
  let facts: () -> FactsView
  let alertType: (CategoryModel.ID) -> CategoriesAlertType?
  let onSelect: Command<CategoryModel.ID>
  let onShowAd: Command<Void>
  let onHideAd: Command<Void>

  @State private var path: [Destination] = .empty
  @State private var alert: CategoriesAlertType?

  var body: some View {
    NavigationStack {
      ZStack {
        Color.purple
          .ignoresSafeArea()
        List {
          ForEach(categories, id: \.self) { id in
            NavigationStack(path: $path) {
              Button(
                action: { onSelectRow(with: id) },
                label: { row(id) }
              )
            }
            .frame(width: UIScreen.main.bounds.width - 60, height: 100)
          }
          .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .navigationDestination(for: Destination.self) {
          switch $0 {
          case .facts: facts()
          }
        }
        if isLoading {
          ProgressView()
        }
      }
    }
    .accentColor(.black)
    .alert(item: $alert) {
      $0.alert {
        onPrimaryAction()
      }
    }
  }

  private func onSelectRow(with id: CategoryModel.ID) {
    guard let alertType = alertType(id) else {
      onSelect.perform(id)
      path.append(.facts)
      return
    }

    alert = alertType
    onSelect.perform(id)
  }

  private func onPrimaryAction() {
    onShowAd.perform()
    asyncOnMainAfterNow(TimeInterval(2)) {
      onHideAd.perform()
      path.append(.facts)
    }
  }
}

extension CategoriesView {
  enum Destination: Hashable {
    case facts
  }
}

enum CategoriesAlertType: String, Identifiable {
  case paid
  case unavailable

  var id: String { self.rawValue }

  func alert(action: (() -> Void)?) -> Alert {
    switch self {
    case .paid:
      return Alert(
        title: Text("Watch Ad to continue"),
        primaryButton: .default(Text("Show Ad"), action: action),
        secondaryButton: .default(Text("Cancel"))
      )

    case .unavailable:
      return Alert(
        title: Text("This section is not yet available"),
        dismissButton: .default(Text("Ok"))
      )
    }
  }
}

struct CategoriesView_Previews: PreviewProvider {
  static var previews: some View {
    CategoriesView(
      isLoading: true,
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
      alertType: { _ in nil },
      onSelect: .nop(),
      onShowAd: .nop(),
      onHideAd: .nop()
    )
  }
}
