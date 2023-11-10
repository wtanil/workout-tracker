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
    var displayNote: String {
        note ?? "..."
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
