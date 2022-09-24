//
//  StorageFactModel.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import Foundation
import RealmSwift

final class StorageFactModel: Object {
  @Persisted var id: UUID
  @Persisted var fact: String
  @Persisted var image: String
}

extension StorageFactModel {
  convenience init(model: FactModel) {
    self.init()

    id = model.id.value
    fact = model.fact
    image = model.image
  }
}

extension StorageFactModel {
  func mapToModel() -> FactModel {
    FactModel(
      id: FactModel.ID(value: id),
      fact: fact,
      image: image
    )
  }
}
