//
//  Activity+extension.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 10/11/23.
//

import Foundation
import CoreData

extension Activity {
   public override func awakeFromInsert() {
      super.awakeFromInsert()
      
      setPrimitiveValue(Int16(0), forKey: "order")
      
   }
}

extension Activity {
   var displayExerciseName: String {
      guard let exercise = exercise else {
         return "Unknown Exercise"
      }
      return exercise.displayName
   }
   
   var displayNote: String { note ?? "" }
   
   var activitySetsAsArray: [ActivitySet] {
      guard let activitySets = sets else {
         return [ActivitySet]()
      }
      let set = activitySets as! Set<ActivitySet>
      let array = Array(set).sorted { $0.createDate! < $1.createDate! }
      return array
   }
   
   var activitySetCount: Int {
      sets?.count ?? 0
   }
   
   var totalValue: Double {
      let activitySets = activitySetsAsArray
      if activitySets.isEmpty {
         return 0
      }
      let totalValue: Double = activitySets.reduce(0) { $0 + $1.totalValue }
      return totalValue
   }
   
   var displayActivitySetUnit: String {
      if activitySetCount == 0 {
         return "-"
      }
      let unit = activitySetsAsArray[0].displayUnit
      return unit
   }
   
   var displayTotalValue: String {
      
      let temp: Double = totalValue
      let unit = displayActivitySetUnit
      
      let string = NumberFormatter.numberFormatterDecimal.string(from: NSNumber(value: temp)) ?? "-"
      if unit == "-" {
         return "\(string)"
      }
      return "\(string) \(unit)"
   }
   
   var bestActivitySet: ActivitySet? {
      let array = activitySetsAsArray.sorted { $0.totalValue > $1.totalValue }
      return array.first
   }
   
   var computedActivitySets: [ActivitySet] {
      get {
         activitySetsAsArray
      }
      set {
         self.sets = NSSet(array: newValue)
      }
   }
   
   func remove(_ activitySet: ActivitySet) {
      if let sets {
         var activitySets = sets as! Set<ActivitySet>
         _ = activitySets.remove(activitySet)
         self.sets = NSSet(set: activitySets)
      }
      
   }
}

extension Activity {
   static func make(in context: NSManagedObjectContext,
                    note: String) -> Activity {
      //        let entityDescription = NSEntityDescription.entity(forEntityName: "Activity", in: context)
      //        let activity = Activity(entity: entityDescription!, insertInto: context)
      let activity = Activity(context: context)
      activity.id = UUID()
      activity.note = note
      return activity
   }
}

/*
 id: UUID
 note: String
 order: Int16
 exercise
 session
 sets
 */
