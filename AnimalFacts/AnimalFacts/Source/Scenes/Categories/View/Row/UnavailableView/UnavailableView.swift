//
//  UnavailableView.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import SwiftUI

// TODO: Design view
struct UnavailableView: View {
  var body: some View {
    Color.black.opacity(0.4)
      .overlay(
        Image(uiImage: Images.comingSoon),
        alignment: .trailing
      )
  }
}

struct UnavailableView_Previews: PreviewProvider {
  static var previews: some View {
    UnavailableView()
  }
}
