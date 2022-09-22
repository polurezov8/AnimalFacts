//
//  FactModel.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

struct FactModel: Decodable, Identifiable {
  typealias ID = Tagged<UUID, FactModel>

  var id = ID(value: UUID())
  let fact: String
  let image: String
}

extension FactModel {
  enum CodingKeys: String, CodingKey {
    case fact
    case image
  }
}
