//
//  Emptyable.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

protocol Emptyable {
  static var empty: Self { get }
}

extension String: Emptyable {
  static var empty: Self { "" }
}

extension Array: Emptyable {
  static var empty: Self { Array() }
}

extension Set: Emptyable {
  static var empty: Self { Set() }
}

extension Dictionary: Emptyable {
  static var empty: Self { Dictionary() }
}

extension Optional where Wrapped: Emptyable {
  var orEmpty: Self { self ?? .empty }
}

protocol EmptyableEquatable: Emptyable, Equatable {
  var isEmpty: Bool { get }
}

extension EmptyableEquatable {
  var isEmpty: Bool { self == .empty }
}
