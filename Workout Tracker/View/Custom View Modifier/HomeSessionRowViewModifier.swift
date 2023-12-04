//
//  HomeSessionRowViewModifier.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 04/12/23.
//

import SwiftUI

struct HomeSessionRow: ViewModifier {
   func body(content: Content) -> some View {
      content
         .cornerRadius(16, antialiased: true)
         .overlay(
            RoundedRectangle(cornerRadius: 16)
               .inset(by: 2)
               .strokeBorder(.red, lineWidth: 2, antialiased: true)
         )
         .listRowSeparator(.hidden)
         .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
   }
}
