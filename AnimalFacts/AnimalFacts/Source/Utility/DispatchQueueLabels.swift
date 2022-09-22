//
//  DispatchQueueLabels.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

enum DispatchQueueLabels: String {
  case store
}

extension DispatchQueueLabels {
  var label: String { "com.animal.facts" + ".\(rawValue)" }
}
