//
//  RequestId.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

enum RequestIdTag {}
typealias RequestId = Tagged<UUID, RequestIdTag>

extension RequestId {
  static func new() -> RequestId { UUID().requestId }
}

extension UUID {
  var requestId: RequestId { RequestId(value: UUID()) }
}
