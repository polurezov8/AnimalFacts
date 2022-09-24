//
//  StackModel.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 23.09.2022.
//

import Foundation
import SwiftUI
import CoreGraphics

class CardStackData<Element: Identifiable>: Identifiable {
  var id: Element.ID { value.id }
  let value: Element

  init(_ value: Element) {
    self.value = value
  }
}

class CardStackModel<Element: Identifiable>: ObservableObject {
  @Published var data: [CardStackData<Element>]
  @Published var currentIndex: Double = .zero
  @Published var previousIndex: Double = .zero
  var maxIndex: Int { data.endIndex - 1 }

  init(_ elements: [Element]) {
    data = elements.map(CardStackData.init)
  }

  func onChanged(translation: CGSize) {
    currentIndex = -(translation.width / 350 - previousIndex)
  }

  func onEnded(_ predictedEndTranslation: CGSize) {
    withAnimation(.default) {
      let translation = predictedEndTranslation.width
      let isTransationEnoughtForSnapping = abs(translation) > 200

      if isTransationEnoughtForSnapping {
        translation > .zero
          ? swipeTo(round(previousIndex) - 1)
          : swipeTo(round(previousIndex) + 1)
      } else {
        currentIndex = round(currentIndex)
      }
    }

    previousIndex = currentIndex
    HapticGenerator.light.impact()
  }

  func swipe() {
    swipeTo(currentIndex + 1)
  }

  func unswipe() {
    swipeTo(currentIndex - 1)
  }

  private func swipeTo(_ index: Double) {
    let maxIndex = Double(maxIndex)

    guard index > .zero else {
      currentIndex = .zero
      previousIndex = .zero
      return
    }

    currentIndex = index > maxIndex ? maxIndex : index
    previousIndex = currentIndex
  }
}
