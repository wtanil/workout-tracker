//
//  ActivitySet+extension.swift
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
        setPrimitiveValue(Date(), forKey: "createDate")
    }
}

extension ActivitySet {
    
    var repAsInt: Int {
        Int(rep)
    }
    var displayType: String {
        type ?? "-"
    }
    var displayUnit: String {
        unit ?? "-"
    }
    
    var displayValue: String {
        NumberFormatter.numberFormatterDecimal.string(from: NSNumber(value: value)) ?? "-"
    }
    
    func setUnit(to newValue: String) {
        self.unit = newValue
        self.objectWillChange.send()
    }
    
    func setRep(to newValue: Int) {
        var newValue = newValue
        if newValue > Int(Int32.max) {
            newValue %= Int(Int32.max)
        }
        self.rep = Int32(newValue)
    }
    
    func setValue(to newValue: Double) {
        self.value = newValue
    }
    
}

extension ActivitySet {
    static func make(in context: NSManagedObjectContext,
                     rep: Int,
                     value: Double,
                     type: String,
                     unit: String
    ) -> ActivitySet {
        //        let entityDescription = NSEntityDescription.entity(forEntityName: "Set", in: context)
        //        let set = Set(entity: entityDescription!, insertInto: context)
        let activitySet = ActivitySet(context: context)
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

