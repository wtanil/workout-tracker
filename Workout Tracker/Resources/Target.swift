//
//  Target.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 08/11/23.
//

import Foundation
enum Target: String, CaseIterable, Identifiable {
    case core = "Core"
    case shoulders = "Shoulders"
    case chest = "Chest"
    case back = "Back"
    case arms = "Arms"
    case legs = "Legs"
    case fullBody = "Full Body"
    case cardio = "Cardio"
    case other = "Other"
    
   var id: Self { self }
}

enum ActivityUnit: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case kg = "kg"
    case lbs = "lbs"
    case sec = "secs"
    case steps = "steps"
    case level = "level"
}
