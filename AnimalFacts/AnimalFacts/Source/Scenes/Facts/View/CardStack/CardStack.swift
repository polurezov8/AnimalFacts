//
//  Stack.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 23.09.2022.
//

import SwiftUI

struct CardStack<Element: Identifiable, Content: View>: View {
  @ObservedObject var model: CardStackModel<Element>
  @ViewBuilder private let content: (Element) -> Content

  init(
    model: CardStackModel<Element>,
    @ViewBuilder content: @escaping (Element) -> Content
  ) {
    self.model = model
    self.content = content
  }

  var body: some View {
    ZStack {
      ForEach(Array(model.data.enumerated()), id: \.element.id) { index, element in
        content(element.value)
          .zIndex(zIndex(for: index))
          .offset(x: xOffset(for: index), y: .zero)
          .scaleEffect(scale(for: index), anchor: .center)
          .opacity(opacity(for: index))
      }
    }
    .highPriorityGesture(dragGesture)
  }

  private var dragGesture: some Gesture {
    DragGesture()
      .onChanged { value in
        withAnimation(.interactiveSpring()) {
          model.onChanged(translation: value.translation)
        }
      }
      .onEnded { value in
        withAnimation(.default) {
          model.onEnded(value.predictedEndTranslation)
        }
      }
  }

  private func zIndex(for index: Int) -> Double {
    Double(index) + 0.7 < model.currentIndex
      ? -Double(model.data.count - index)
      : Double(model.data.count - index)
  }

  private func xOffset(for index: Int) -> CGFloat {
    let topCardProgress = currentPosition(for: index)
    let padding = 35.0
    let x = ((CGFloat(index) - model.currentIndex) * padding)
    return topCardProgress > .zero && topCardProgress < 0.99 && index < model.maxIndex
      ? x * swingOutMultiplier(topCardProgress)
      : x
  }

  private func swingOutMultiplier(_ progress: Double) -> Double {
    sin(Double.pi * progress) * 18
  }

  private func scale(for index: Int) -> CGFloat {
    let scale = 1.0 - (0.1 * abs(currentPosition(for: index)))
    return scale == .zero ? 0.01 : scale
  }

  private func opacity(for index: Int) -> Double {
    Double(index) == model.currentIndex
      ? 1
      : 1.0 - (0.1 * abs(currentPosition(for: index)))
  }

  private func currentPosition(for index: Int) -> Double {
    model.currentIndex - Double(index)
  }
}
