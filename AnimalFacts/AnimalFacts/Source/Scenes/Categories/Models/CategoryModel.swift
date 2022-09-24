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

extension CategoryModel {
  static let mock = CategoryModel(
    title: Mock.String.title,
    description: Mock.String.subtitle,
    image: .empty,
    order: .zero,
    status: .free,
    content: .empty
  )

  static var mockArray: [CategoryModel] {
    var result: [CategoryModel] = .empty
    for index in 0..<10 {
      result.append(CategoryModel(
        title: "\(Mock.String.title) \(index)",
        description: "\(Mock.String.subtitle) \(index)",
        image: "image \(index)",
        order: index,
        status: index.isMultiple(of: 2) ? .free : .paid,
        content: .empty
      ))
    }

    return result
  }
}
