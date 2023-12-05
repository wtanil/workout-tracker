//
//  ShowSessionViewModifier.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 04/12/23.
//

import SwiftUI

struct ShowSessionRowViewModifier: ViewModifier {
   func body(content: Content) -> some View {
      content
//         .background(Color.gray.opacity(0.2))
         .cornerRadius(16, antialiased: true)
         .overlay(
            RoundedRectangle(cornerRadius: 16)
               .inset(by: 0)
               .strokeBorder(.green, lineWidth: 2, antialiased: true)
         )
   }
}
