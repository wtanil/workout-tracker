//
//  ActivityUnit.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 24/11/23.
//

import Foundation

enum ActivityUnit: String, CaseIterable, Identifiable {
   var id: String { self.rawValue }
   
   case kg = "kg"
   case lbs = "lbs"
   case sec = "secs"
   case steps = "steps"
   case level = "level"
}
