//
//  AppReducer.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

extension AppState {
  mutating func reduce(_ action: Action) {
    debugPrint(action)
  }
}
