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
 primaryMuscles: [String]
 instructions: [String]
 category: String
 */

/*
 make(in context: NSManagedObjectContext,
 name: String,
 link: String,
 note: String,
 instructions: [String],
 category: Category,
 equipment: Equipment,
 force: Force,
 level: Level,
 mechanic: Mechanic,
 muscle: Muscle
 ) -> Exercise
 */

struct Workout: Codable {
   let name: String
   let instructions: [String]
   let category: String
   let equipment: String // null to .other
   let force: String // null to .other
   let level: String
   let mechanic: String // null to .other
   let primaryMuscles: [String]
   
//   let id: UUID = UUID() // need to remember initializing id = UUID() before inserting to core data
}
