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
   
   var totalValues: [String: Double] {
      let activitySets = activitySetsAsArray
      if activitySets.isEmpty {
         return [String: Double]()
      }
      let dict = Dictionary(grouping: activitySets) { $0.displayUnit
      }
      var sumDict = [String: Double]()
      for (unit, sets) in dict {
         sumDict[unit] = sets.reduce(0) { $0 + $1.totalValue }
      }
      
      return sumDict
   }
   
   var displayTotalValue: String {
      let totalValuesDict = totalValues
      let totalValue = totalValuesDict.max { $0.value > $1.value }
      let string = NumberFormatter.numberFormatterDecimal.string(from: NSNumber(value: totalValue!.value)) ?? "-"
      return "\(string) \(totalValue!.key)"
   }
   
   var displayTotalValues: String {
      let totalValuesDict = totalValues.sorted { lhs, rhs in
         lhs.value > rhs.value
      }
      let string = totalValuesDict.map { unit, value in
         let temp = NumberFormatter.numberFormatterDecimal.string(from: NSNumber(value: value)) ?? "-"
         return "\(temp) \(unit)"
      }.joined(separator: ", ")

      return string
   }
   
   var displayActivitySetUnit: String {
      if activitySetCount == 0 {
         return "-"
      }
      let unit = activitySetsAsArray[0].displayUnit
      return unit
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
