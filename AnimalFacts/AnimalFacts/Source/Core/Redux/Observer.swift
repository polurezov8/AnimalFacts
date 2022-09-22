//
//  Observer.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

class Observer<State>: Hashable {
  static func == (lhs: Observer<State>, rhs: Observer<State>) -> Bool {
    ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
  }

  func hash(into hasher: inout Hasher) {
    ObjectIdentifier(self).hash(into: &hasher)
  }

  enum Status {
    case active
    case postponed(Int)
    case dead
  }

  let queue: DispatchQueue
  let observe: (State) -> Status

  init(queue: DispatchQueue, observe: @escaping (State) -> Status) {
    self.queue = queue
    self.observe = observe
  }
}
