//
//  HapticGenerator.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import UIKit

typealias HapticGenerator = UIImpactFeedbackGenerator.FeedbackStyle

extension HapticGenerator {
  func impact() {
    UIImpactFeedbackGenerator(style: self).impactOccurred()
  }
}
