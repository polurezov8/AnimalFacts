//
//  PerformOnMain.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

func asyncOnMainAfterNow(_ delay: TimeInterval, _ closure: @escaping () -> Void) {
  guard delay >= .zero else {
    debugPrint("Warning: asyncOnMainAfterNow delay < .zero")
    return
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
