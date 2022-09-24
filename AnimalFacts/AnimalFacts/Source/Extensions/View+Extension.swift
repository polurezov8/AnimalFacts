//
//  View+Extension.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import SwiftUI

extension View {
  func navigationBarTitleTextColor(_ color: Color) -> some View {
    let uiColor = UIColor(color)

    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]

    return self
  }
}
