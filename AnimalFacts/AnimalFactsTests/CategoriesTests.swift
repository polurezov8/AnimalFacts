//
//  CategoriesTests.swift
//  AnimalFactsTests
//
//  Created by Dmitry Polurezov on 24.09.2022.
//

import XCTest
@testable import AnimalFacts

final class CategoriesTests: XCTestCase {
  var categoriesState = CategoriesState()

  override func tearDown() {
    categoriesState = CategoriesState()

    super.tearDown()
  }

  func testFetch() {
    let beginAction = CategoriesAction.Begin()
    reduce(beginAction)
    XCTAssertNotNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.loadRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
  }

  func testFetchedEmpty() {
    let fetchedAction = CategoriesAction.Fetched(models: .empty)
    reduce(fetchedAction)
    XCTAssertTrue(categoriesState.models.isEmpty)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
    XCTAssertNotNil(categoriesState.loadRequestId)
  }

  func testFetchedNonEmpty() {
    let fetchedAction = CategoriesAction.Fetched(models: CategoryModel.mockArray)
    reduce(fetchedAction)
    XCTAssertFalse(categoriesState.models.isEmpty)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.loadRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
  }

  func testFetchfailed() {
    let fetchFailedAction = CategoriesAction.FetchFailed()
    reduce(fetchFailedAction)
    XCTAssertTrue(categoriesState.models.isEmpty)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
    XCTAssertNotNil(categoriesState.loadRequestId)
  }

  func testLoadedNonEmpty() {
    let loadedAction = CategoriesAction.Loaded(models: CategoryModel.mockArray)
    reduce(loadedAction)
    XCTAssertFalse(categoriesState.models.isEmpty)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.loadRequestId)
    XCTAssertNotNil(categoriesState.writeRequestId)
  }

  func testLoadedEmpty() {
    let loadedAction = CategoriesAction.Loaded(models: .empty)
    reduce(loadedAction)
    XCTAssertTrue(categoriesState.models.isEmpty)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.loadRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
  }

  func testLoadFailed() {
    let loadFailedAction = CategoriesAction.LoadFailed()
    reduce(loadFailedAction)
    XCTAssertNil(categoriesState.loadRequestId)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
  }

  func testWriteSucceeded() {
    let writeSucceededAction = CategoriesAction.WriteSucceeded()
    reduce(writeSucceededAction)
    XCTAssertNil(categoriesState.loadRequestId)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
  }

  func testWriteFailed() {
    let writeSucceededAction = CategoriesAction.WriteFailed()
    reduce(writeSucceededAction)
    XCTAssertNil(categoriesState.loadRequestId)
    XCTAssertNil(categoriesState.fetchRequestId)
    XCTAssertNil(categoriesState.writeRequestId)
  }

  func testShowingAd() {
    let showAdAction = CategoriesAction.ShowAd()
    reduce(showAdAction)
    XCTAssertTrue(categoriesState.isShowingAd)

    let hideAdAction = CategoriesAction.HideAd()
    reduce(hideAdAction)
    XCTAssertFalse(categoriesState.isShowingAd)
  }

  func testOrdering() {
    let loadedAction = CategoriesAction.Loaded(models: CategoryModel.mockArray)
    reduce(loadedAction)
    categoriesState.models
      .enumerated()
      .forEach { XCTAssertTrue($0 == $1.order) }
  }

  private func reduce(_ action: Action) {
    categoriesState.reduce(action)
  }
}
