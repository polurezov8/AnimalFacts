//
//  Sorted.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

@propertyWrapper
struct Sorted<Element, SortProperty: Comparable> {
  private var array: [Element] = []
  private let sortProperty: KeyPath<Element, SortProperty>

  init(wrappedValue: [Element], by sortProperty: KeyPath<Element, SortProperty>) {
    self.sortProperty = sortProperty
    self.wrappedValue = wrappedValue
  }

  var wrappedValue: [Element] {
    get { array }
    set { array = newValue.sorted(by: { $0[keyPath: sortProperty] < $1[keyPath: sortProperty] }) }
  }
}
