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
