//
//  CategoryModel.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

struct CategoryModel: Decodable {
  typealias ID = Tagged<UUID, CategoryModel>

  var id = ID(value: UUID())
  let title: String
  let description: String
  let image: String
  let order: Int
  let status: Status
  let content: [FactModel]?
}

extension CategoryModel {
  enum CodingKeys: String, CodingKey {
    case title
    case description
    case image
    case order
    case status
    case content
  }
}

extension CategoryModel {
  enum Status: String, Decodable {
    case paid
    case free
  }
}
