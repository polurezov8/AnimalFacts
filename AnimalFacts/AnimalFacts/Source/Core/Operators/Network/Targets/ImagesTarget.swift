//
//  ImagesTarget.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation
import SwiftUI
import UIKit

struct ImagesTarget: NetworkTarget {
  typealias Operation = NetworkOperator.Operation

  @Environment(\.imageCache) var imageCache

  func map(state: AppState, client: Client, dispatch: @escaping ReduxDispatch) -> [Operation] {
    var operations: [Operation] = .empty

    state.categories.models.forEach { category in
      operations.append(fire(
        uuid: RequestId(value: category.id.value),
        request: client.getImage(by: category.image),
        dispatch: dispatch,
        onComplete: { response in
          switch response {
          case let .success(data):
            guard let image = UIImage(data: data) else {
              return CategoriesAction.ImageLoadFailed()
            }

            imageCache.store(image, for: .category(category.id) )
            return CategoriesAction.ImageLoaded()

          default:
            return CategoriesAction.ImageLoadFailed()
          }
        }
      ))
    }

    state.facts.models.forEach { fact in
      operations.append(fire(
        uuid: RequestId(value: fact.id.value),
        request: client.getImage(by: fact.image),
        dispatch: dispatch,
        onComplete: { response in
          switch response {
          case let .success(data):
            guard let image = UIImage(data: data) else {
              return CategoriesAction.ImageLoadFailed()
            }

            imageCache.store(image, for: .fact(fact.id))
            return FactsAction.ImageLoaded()

          default:
            return FactsAction.ImageLoadFailed()
          }
        }
      ))
    }

    return operations
  }
}
