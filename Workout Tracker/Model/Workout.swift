//
//  Workout.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 24/11/23.
//

import Foundation
/*
 id: String
 name: String
 force: String?
 level: String
 mechanic: String?
 equipment: String?
 primaryMuscle: [String]
 secondaryMuscle: [String]
 instructions: [String]
 category: String
 */

struct Workout: Codable {
   let name: String
   let force: String // null to .other
   let level: String
   let mechanic: String // null to .other
   let equipment: String // null to .other
   let primaryMuscles: [String]
   let secondaryMuscles: [String]
   let instructions: [String]
   let category: String
//   let id: UUID = UUID() // need to remember initializing id = UUID() before inserting to core data
   
}
