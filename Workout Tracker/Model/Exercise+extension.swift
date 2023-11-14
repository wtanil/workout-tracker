//
//  Exercise+extension.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 10/11/23.
//

import Foundation
import CoreData

extension Exercise {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
    }
}

extension Exercise {
    var displayName: String {
        name ?? "Unknown Name"
    }
    
    var displayCategory: String {
        category ?? "-"
    }
    
    // needed to make SectionedFetchRequest work
    @objc
    var displayTarget: String {
        target ?? "-"
    }
    
    var displayLink: String {
        link ?? ""
    }
    
    var displayNote: String {
        note ?? ""
    }
}

extension Exercise {
    static func make(in context: NSManagedObjectContext,
                     name: String,
                     category: String,
                     target: String,
                     link: String,
                     note: String
                     ) -> Exercise {
//        let entityDescription = NSEntityDescription.entity(forEntityName: "Exercise", in: context)
//        let exercise = Exercise(entity: entityDescription!, insertInto: context)
        let exercise = Exercise(context: context)
        exercise.id = UUID()
        exercise.category = category
        exercise.link = link
        exercise.name = name
        exercise.note = note
        exercise.target = target
        
        return exercise
    }
}

/*
 category: String
 id: UUID
 link: String
 name: String
 note: String
 target: String
 activities
 */
