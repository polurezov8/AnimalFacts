//
//  NetworkDriver.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

struct NetworkDriver: SideEffectsDriver {
  typealias Operator = NetworkOperator

  let store: Store
  let client: Client
  let `operator`: Operator
  let targets: [NetworkTarget] = [
    CategoriesTarget()
  ]

  func subscribe(_ component: Operator) -> Observer<AppState> {
    Observer(queue: self.operator.queue) { state in
      component.props = map(state: state)
      return .active
    }
  }

  func map(state: AppState) -> Props {
    targets.flatMap {
      $0.map(state: state, client: client, dispatch: store.dispatch)
    }
  }
}
