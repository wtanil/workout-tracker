//
//  Sessions+extension.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 08/11/23.
//

import Foundation
import CoreData

extension Sessions {
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
