//
//  Set+extension.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 10/11/23.
//

import Foundation
import CoreData

extension Set {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(0, forKey: "rep")
        setPrimitiveValue(0, forKey: "value")
        setPrimitiveValue("kg", forKey: "unit")
        setPrimitiveValue(false, forKey: "isBodyWeight")
        setPrimitiveValue(false, forKey: "isFailure")
    }
}

extension Set {
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

extension Set {
    static func make(in context: NSManagedObjectContext,
                     order: Int,
                     rep: Int,
                     value: Double,
                     type: String,
                     unit: String
    ) -> Set {
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Set", in: context)
//        let set = Set(entity: entityDescription!, insertInto: context)
        let set = Set(context: context)
        set.order = Int16(order)
        set.rep = Int32(rep)
        set.value = value
        set.type = type
        set.unit = unit
        
        return set
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
