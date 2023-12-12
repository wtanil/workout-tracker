//
//  Session+extension.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 10/11/23.
//

import Foundation
import CoreData

extension Session {
   public override func awakeFromInsert() {
      super.awakeFromInsert()
      
      setPrimitiveValue("", forKey: "name")
      setPrimitiveValue("", forKey: "note")
      setPrimitiveValue(Date(), forKey: "date")
      setPrimitiveValue(Date(), forKey: "createDate")
      setPrimitiveValue(Date(), forKey: "updateDate")
   }
   
   override public func willSave() {
      if let updateDate = updateDate {
         let timedifference = Date().timeIntervalSinceReferenceDate - updateDate.timeIntervalSinceReferenceDate
         if timedifference > 10 {
            self.updateDate = Date()
         }
      } else {
         self.updateDate = Date()
      }
      super.willSave()
   }
}

extension Session {
   var displayName: String { name ?? "-" }
   
   var displayNote: String { note ?? "" }
   
   var displayDate: String { formattedDate(for: date) }
   
   var displayCreateDate: String { formattedDate(for: createDate) }
   
   var displayUpdateDate: String { formattedDate(for: updateDate) }
   
   private func formattedDate(for date: Date?) -> String {
      guard let date = date else { return "Unknown date" }
      return DateFormatter.dateFormatterMediumShort.string(from: date)
   }
   
   var activitiesAsArray: [Activity] {
      guard let activities = activities else {
         return [Activity]()
      }
      let set = activities as! Set<Activity>
      let array: [Activity] = Array(set).sorted { $0.order < $1.order }
      return array
   }
   
   var computedActivities: [Activity] {
      get {
         activitiesAsArray
      }
      set {
         self.activities = NSSet(array: newValue)
      }
   }
   
   var activityCount: Int {
      activities?.count ?? 0
   }
   
   var displayActivityCount: String {
      "\(activityCount)"
   }
   
   var totalValues: [String: Double] {
      let array = activitiesAsArray
      var dict = [String: Double]()
      for activity in array {
         for (unit, value) in activity.totalValues {
            dict[unit, default: 0] += value
         }
      }
      return dict
   }
   
   var displayTotalValues: String {
      let dict = totalValues.sorted { $0.value > $1.value }
      if dict.isEmpty {
         return "-"
      }
      let string = dict.map { unit, value in
         let temp = NumberFormatter.numberFormatterDecimal.string(from: NSNumber(value: value)) ?? "-"
         return "\(temp) \(unit)"
      }.joined(separator: ", ")
      return string
   }
   
   var totalValue: Double {
      
//      return activitiesAsArray.reduce(0, { $0 + $1.totalValue })
      return 0
   }
   
}

extension Session {
   static func make(in context: NSManagedObjectContext,
                    name: String,
                    date: Date,
                    note: String
   ) -> Session {
      //        let entityDescription = NSEntityDescription.entity(forEntityName: "Session", in: context)
      //        let session = Session(entity: entityDescription!, insertInto: context)
      let session = Session(context: context)
      session.name = name
      session.date = date
      session.note = note
      
      return session
   }
}

/*
 createDate: Date
 date: Date
 name: String
 note: String
 updateDate: Date
 activities
 */
