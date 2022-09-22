//
//  Tagged.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

struct Tagged<ValueType: Codable & Hashable, Tag>: Codable, Hashable {
  let value: ValueType

  init(value: ValueType) {
    self.value = value
  }

  init?(optional: ValueType?) {
    guard let value = optional else { return nil }
    self.init(value: value)
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    value = try container.decode(ValueType.self)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value)
  }
}

extension Tagged: Comparable where ValueType: Comparable {
  static func < (left: Self, right: Self) -> Bool {
    left.value < right.value
  }
}

extension Tagged: CustomDebugStringConvertible {
  public var debugDescription: String { "\(String(describing: value))<\(Tag.self)>" }
}
