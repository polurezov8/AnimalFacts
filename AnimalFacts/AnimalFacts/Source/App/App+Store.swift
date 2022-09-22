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

    connectNetworkDriver(to: store)

    store.dispatch(action: CategoriesAction.Begin())

    return store
  }

  private func connectNetworkDriver(to store: Store) {
    guard let baseURL = URL(string: "https://drive.google.com/uc") else {
      return
    }

    let client = Client(baseURL: baseURL)
    let networkOperator = NetworkOperator()
    let networkDriver = NetworkDriver(store: store, client: client, operator: networkOperator)
    store.subscribe(observer: networkDriver.subscribe(networkOperator))
  }
}
