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
        
    }
}

extension Activity {
    static func make(in context: NSManagedObjectContext, notes: String?) -> Activity {
        let entityDescription = NSEntityDescription.entity(forEntityName: "Activity", in: context)
        let activity = Activity(entity: entityDescription!, insertInto: context)
        activity.id = UUID()
        return activity
    }
}
    
    /*
     id: UUID
     notes: String
     order: Int16
     exercise
     session
     sets
     */
