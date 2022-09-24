//
//  CategoriesAlertType.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import SwiftUI

enum CategoriesAlertType: String, Identifiable {
  case paid
  case unavailable

  var id: String { rawValue }

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
