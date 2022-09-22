//
//  Client+Categories.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

extension Client {
  func getCategories(id: RequestId) -> Request<[CategoryModel]> {
    request(urlRequest: get(
      from: .base,
      with: [
        URLQueryItem(name: "export", value: "download"),
        URLQueryItem(name: "id", value: "12L7OflAsIxPOF47ssRdKyjXoWbUrq4V5")
      ]
    ))
  }
}
