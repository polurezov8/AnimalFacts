//
//  StorageCategoryModel.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import Foundation
import RealmSwift

final class StorageCategoryModel: Object {
  @Persisted var id: UUID
  @Persisted var title: String
  @Persisted var details: String
  @Persisted var image: String
  @Persisted var order: Int
  @Persisted var status: String
  @Persisted var content: List<StorageFactModel>
}

extension StorageCategoryModel {
  convenience init(model: CategoryModel) {
    self.init()

    let contentList: List<StorageFactModel> = {
      let result = List<StorageFactModel>()
      guard let models = model.content else { return result }
      result.append(objectsIn: models.map { StorageFactModel(model: $0) })
      return result
    }()

    id = model.id.value
    title = model.title
    details = model.description
    image = model.image
    order = model.order
    status = model.status.rawValue
    content = contentList
  }
}

extension StorageCategoryModel {
  func mapToModel() -> CategoryModel {
    CategoryModel(
      id: CategoryModel.ID(value: id),
      title: title,
      description: details,
      image: image,
      order: order,
      status: CategoryModel.Status(rawValue: status) ?? .free,
      content: content.map { $0.mapToModel() }
    )
  }
}
