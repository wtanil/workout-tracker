//
//  ActivitySet.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 10/11/23.
//

import Foundation
import CoreData

extension ActivitySet {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(0, forKey: "rep")
        setPrimitiveValue(0, forKey: "value")
        setPrimitiveValue("kg", forKey: "unit")
        setPrimitiveValue(false, forKey: "isBodyWeight")
        setPrimitiveValue(false, forKey: "isFailure")
    }
}

extension ActivitySet {
    var orderAsInt: Int {
        Int(order)
    }
    var repAsInt: Int {
        Int(rep)
    }
    var displayType: String {
        type ?? "-"
    }
    var displayUnit: String {
        unit ?? "-"
    }
    
}

extension ActivitySet {
    static func make(in context: NSManagedObjectContext,
                     order: Int,
                     rep: Int,
                     value: Double,
                     type: String,
                     unit: String
    ) -> ActivitySet {
        //        let entityDescription = NSEntityDescription.entity(forEntityName: "Set", in: context)
        //        let set = Set(entity: entityDescription!, insertInto: context)
        let activitySet = ActivitySet(context: context)
        activitySet.order = Int16(order)
        activitySet.rep = Int32(rep)
        activitySet.value = value
        activitySet.type = type
        activitySet.unit = unit
        
        return activitySet
    }
}

/*
 isBodyWeight: Boolean
 isFailure: Boolean
 order: Integer 16
 rep: Integer 32
 type: String
 unit: String
 value: Integer 32
 activity
 */
