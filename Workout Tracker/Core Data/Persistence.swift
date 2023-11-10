//
//  Persistence.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 30/10/23.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Workout_Tracker")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // from Donny Wals presentation about Core Data and SwiftUI
    func childViewContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = container.viewContext
        return context
    }
    
    // from Donny Wals presentation about Core Data and SwiftUI
    func newTemporaryInstance<T: NSManagedObject>(in context: NSManagedObjectContext) -> T {
        let entityDescription: NSEntityDescription = NSEntityDescription.entity(forEntityName: String(describing: T.self), in: context)!
        return T(entity: entityDescription, insertInto: context)
    }
    
    // from Donny Wals presentation about Core Data and SwiftUI
    func copyForEditing<T: NSManagedObject>(of object: T, in context: NSManagedObjectContext) -> T {
        guard let object = (try? context.existingObject(with: object.objectID)) as? T else {
            fatalError("Requested copy of a managed object that doesn't exist")
        }
        return object
    }
    
    func delete<T: NSManagedObject>(_ object: T, in context: NSManagedObjectContext) {
        context.delete(object)
    }
    
    // from Donny Wals presentation about Core Data and SwiftUI
    func persist(_ object: NSManagedObject) {
        do {
            try object.managedObjectContext?.save()
            if let parent = object.managedObjectContext?.parent {
                try parent.save()
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func persist(for context: NSManagedObjectContext) {
        do {
            try context.save()
            if let parent = context.parent {
                try parent.save()
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

extension PersistenceController {
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        // Adding placeholder items for preview
        // Exercises
        var exercises = [Exercises]()
        for index in 0 ..< 10 {
            let newExercise = Exercises(context: viewContext)
            newExercise.target = Target.allCases[index % 9].rawValue
            newExercise.id = UUID()
            newExercise.name = "Exercise \(index)"
            newExercise.note = "Note Note \(index)"
            newExercise.link = "Link Link \(index)"
            newExercise.category = Category.allCases[index % 7].rawValue
            exercises.append(newExercise)
        }
        // Session Activities Sets
        // new Session
        let newSession = Sessions(context: viewContext)
        newSession.name = "Session 1"
        var activities = [Activities]()
        for index in 0 ..< 5 {
            let newActivity = Activities(context: viewContext)
            newActivity.id = UUID()
            newActivity.order = Int16(index)
            newActivity.session = newSession
            newActivity.exercise = exercises[index]
            activities.append(newActivity)
        }
        
        for index in 0 ..< 12 {
            let newSet = Sets(context: viewContext)
            newSet.isFailure = false
            newSet.isBodyWeight = false
            newSet.order = Int16(index)
            newSet.rep = Int32.random(in: 5 ... 10)
            newSet.type = "type \(index)"
            newSet.unit = "unit \(index)"
            newSet.value = Int32.random(in: 50 ... 100)
            newSet.activity = activities[index % 5]
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
