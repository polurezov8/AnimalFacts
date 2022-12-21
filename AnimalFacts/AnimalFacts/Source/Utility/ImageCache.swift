//
//  ImageCache.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Combine
import SwiftUI

enum ImageCacheTypeID {
  case category(CategoryModel.ID)
  case fact(FactModel.ID)
}

protocol ImageCacheProtocol {
  func store(_ image: UIImage, for id: ImageCacheTypeID)
  func image(for id: ImageCacheTypeID) -> UIImage
}

class ImageCache: ImageCacheProtocol {
  typealias ID = ImageCacheTypeID
  private var categories: [CategoryModel.ID: UIImage] = .empty
  private var facts: [FactModel.ID: UIImage] = .empty

  func store(_ image: UIImage, for id: ID) {
    switch id {
    case let .category(categoryId):
      return categories[categoryId] = image
    case let .fact(factId):
      return facts[factId] = image
    }
  }

  func image(for id: ID) -> UIImage {
    switch id {
    case let .category(categoryId):
      return categories[categoryId] ?? UIImage(named: "pets")!
    case let .fact(factId):
      return facts[factId] ?? UIImage(named: "pets")!
    }
  }
}
