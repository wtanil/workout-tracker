//
//  SectionHeader.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 04/12/23.
//

import SwiftUI

struct SectionHeader: ViewModifier {
   func body(content: Content) -> some View {
      content
         .font(.title2.weight(.bold))
   }
}
