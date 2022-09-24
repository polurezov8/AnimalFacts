//
//  FactsAction.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

enum FactsAction {
  struct Begin: Action {
    let category: CategoryModel.ID
    let models: [FactModel]
  }

  struct ImageLoaded: Action {}
  struct ImageLoadFailed: Action {}
}
