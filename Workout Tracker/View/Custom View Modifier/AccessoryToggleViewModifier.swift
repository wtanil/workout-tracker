//
//  AccesoryToggleViewModifier.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 04/12/23.
//

import SwiftUI

struct AccessoryToggle: ViewModifier {
   func body(content: Content) -> some View {
      content
         .toggleStyle(.button)
         .tint(.blue)
         .cornerRadius(16, antialiased: true)
         .overlay(
            RoundedRectangle(cornerRadius: 16)
               .inset(by: 0)
               .strokeBorder(.blue, lineWidth: 2, antialiased: true)
         )
   }
}
