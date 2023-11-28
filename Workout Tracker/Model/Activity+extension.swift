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
