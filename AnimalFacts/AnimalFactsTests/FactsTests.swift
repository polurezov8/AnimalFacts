//
//  FactsTests.swift
//  AnimalFactsTests
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import XCTest
@testable import AnimalFacts

final class FactsTests: XCTestCase {
  var factsState = FactsState()

  override func tearDown() {
    factsState = FactsState()

    super.tearDown()
  }

  func testBegin() {
    let beginAction = FactsAction.Begin(
      category: CategoryModel.ID(value: UUID()),
      models: FactModel.mockArray
    )

    reduce(beginAction)
    XCTAssertNotNil(factsState.category)
    XCTAssertFalse(factsState.models.isEmpty)
  }

  private func reduce(_ action: Action) {
    factsState.reduce(action)
  }
}
