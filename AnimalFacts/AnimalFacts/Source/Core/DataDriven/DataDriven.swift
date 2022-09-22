//
//  DataDriven.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

protocol DataDriven {
  associatedtype Props
  var props: Props { get set }
}
