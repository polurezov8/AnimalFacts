//
//  SideEffectsDriver.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

protocol SideEffectsDriver {
  associatedtype Operator: SideEffectsOperator
  typealias Props = Operator.Props

  var store: Store { get }
  var dispatch: Command<Action> { get }

  func subscribe(_ component: Operator) -> Observer<AppState>
  func map(state: AppState) -> Props
}

extension SideEffectsDriver {
  var dispatch: Command<Action> { .init { store.dispatch(action: $0) } }
}
