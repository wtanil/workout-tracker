//
//  Exercise+extension.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 10/11/23.
//

import Foundation
import CoreData

extension Exercise {
   public override func awakeFromInsert() {
      super.awakeFromInsert()
      
   }
}

extension Exercise {
   
   var displayName: String { name ?? "Unknown Name" }
   
   var displayLink: String { link ?? "" }
   
   var displayNote: String { note ?? "" }
   
   var displayCategory: String { category?.name ?? "-" }
   
   var displayEquipment: String { equipment?.name ?? "-" }
   
   var displayForce: String { force?.name ?? "-" }
   
   // instructions
   var instructionsAsArray: [String] {
      let data = Data(instructions!.utf8)
      return (try? JSONDecoder().decode([String].self, from: data)) ?? [String]()
   }
   
   var computedInstructions: [String] {
      get {
         instructionsAsArray
      }
      set {
         guard let data = try? JSONEncoder().encode(newValue), let string = String(data: data, encoding: .utf8) else {
            instructions = ""
            return
         }
         instructions = string
      }
   }
   
   var displayLevel: String { level?.name ?? "-" }
   
   var displayMechanic: String { mechanic?.name ?? "-" }
   
   @objc
   var displayMuscle: String { muscle?.name ?? "-" }
   
}

extension Exercise {
   
   static func make(in context: NSManagedObjectContext,
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
   ) -> Exercise {
      let exercise = Exercise(context: context)
      exercise.id = UUID()
      exercise.name = name
      exercise.link = link
      exercise.note = note
      exercise.computedInstructions = instructions
      exercise.category = category
      exercise.equipment = equipment
      exercise.force = force
      exercise.level = level
      exercise.mechanic = mechanic
      exercise.muscle = muscle
      
      return exercise
   }
}
