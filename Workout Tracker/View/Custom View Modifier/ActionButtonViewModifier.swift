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
         .background(Color.green.opacity(1))
         .cornerRadius(16)
   }
}
