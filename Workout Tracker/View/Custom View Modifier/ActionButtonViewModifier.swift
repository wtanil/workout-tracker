//
//  ActionButtonViewModifier.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 04/12/23.
//

import SwiftUI

struct ActionButton: ViewModifier {
   func body(content: Content) -> some View {
      content
         .background(.red.opacity(0.25))
         .cornerRadius(16)
   }
}
