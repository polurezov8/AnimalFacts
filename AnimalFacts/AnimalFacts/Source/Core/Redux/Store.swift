//
//  Store.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Dispatch
import Foundation

class ReduxStore<State> {
  typealias Reducer = (inout State, Action) -> Void
  private let queue = DispatchQueue(label: DispatchQueueLabels.store.label, qos: .userInitiated)

  init(initial state: State, reducer: @escaping Reducer) {
    self.reducer = reducer
    self.state = state
  }

  let reducer: Reducer
  private(set) var state: State
  private var observers: Set<Observer<State>> = .empty

  func dispatch(action: Action) {
    queue.sync {
      self.reducer(&self.state, action)
      self.observers.forEach(self.notify)
    }
  }

  func subscribe(observer: Observer<State>) {
    queue.sync {
      self.observers.insert(observer)
      self.notify(observer)
    }
  }

  private func notify(_ observer: Observer<State>) {
    let state = self.state
    observer.queue.async {
      let status = observer.observe(state)

      if case .dead = status {
        self.queue.async { self.observers.remove(observer) }
      }
    }
  }
}
