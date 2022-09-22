//
//  App+Store.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

extension AnimalFactsApp {
  func setupStore() -> Store {
    let store = Store(initial: AppState()) { state, action in
      state.reduce(action)
    }

    store.dispatch(action: CategoriesAction.Begin())

    return store
  }
}
