//
//  CategoriesAction.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

enum CategoriesAction {
  struct Begin: Action {}

  struct Loaded: Action {
    let models: [CategoryModel]
  }

  struct LoadFailed: Action {}
  struct ImageLoaded: Action {}
  struct ImageLoadFailed: Action {}
  struct ShowAd: Action {}
  struct HideAd: Action {}
}
