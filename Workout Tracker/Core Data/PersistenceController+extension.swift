//
//  PersistenceController+extension.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 28/11/23.
//

import CoreData

extension PersistenceController {
   func initializeCategories(in context: NSManagedObjectContext) -> [String: Category] {
      let categories = ["powerlifting",
                        "strength",
                        "stretching",
                        "cardio",
                        "olympic weightlifting",
                        "strongman",
                        "plyometrics"
      ]
      var dict = [String: Category]()
      // initialize CATEGORY
      for category in categories {
         let newCategory = Category(context: context)
         newCategory.name = category
         dict[category] = newCategory
      }
      return dict
   }
   
   func initializeEquipments(in context: NSManagedObjectContext) -> [String: Equipment] {
      // possibility of NULL
      let equipments = ["medicine ball",
                        "dumbbell",
                        "body only",
                        "bands",
                        "kettlebells",
                        "foam roll",
                        "cable",
                        "machine",
                        "barbell",
                        "exercise ball",
                        "e-z curl bar",
                        "other"
      ]
      var dict = [String: Equipment]()
      for equipment in equipments {
         let newEquipment = Equipment(context: context)
         newEquipment.name = equipment
         dict[equipment] = newEquipment
      }
      return dict
   }
   
   func initializeForces(in context: NSManagedObjectContext) -> [String: Force] {
      // possibility of NULL
      let forces = ["static",
                    "pull",
                    "push",
                    "other"
      ]
      var dict = [String: Force]()
      for force in forces {
         let newForce = Force(context: context)
         newForce.name = force
         dict[force] = newForce
      }
      
      return dict
   }
   
   func initializeLevels(in context: NSManagedObjectContext) -> [String: Level] {
      let levels = ["beginner",
                    "intermediate",
                    "expert"
      ]
      var dict = [String: Level]()
      for level in levels {
         let newLevel = Level(context: context)
         newLevel.name = level
         dict[level] = newLevel
      }
      return dict
   }
   
   func initializeMechanics(in context: NSManagedObjectContext) -> [String: Mechanic] {
      // possiblity of NULL
      let mechanics = ["isolation",
                       "compound",
                       "other"]
      var dict = [String: Mechanic]()
      for mechanic in mechanics {
         let newMechanic = Mechanic(context: context)
         newMechanic.name = mechanic
         dict[mechanic] = newMechanic
      }
      return dict
   }
   
   func initializeMuscles(in context: NSManagedObjectContext) -> [String: Muscle] {
      let muscles = ["abdominals",
                     "abductors",
                     "adductors",
                     "biceps",
                     "calves",
                     "chest",
                     "forearms",
                     "glutes",
                     "hamstrings",
                     "lats",
                     "lower back",
                     "middle back",
                     "neck",
                     "quadriceps",
                     "shoulders",
                     "traps",
                     "triceps"
      ]
      var dict = [String: Muscle]()
      for muscle in muscles {
         let newMuscle = Muscle(context: context)
         newMuscle.name = muscle
         dict[muscle] = newMuscle
      }
      return dict
   }
   
   
   //   func initialize(in context: NSManagedObjectContext) {
   //
   //      let categoryDict = initializeCategories(in: context)
   //      let equipmentDict = initializeEquipments(in: context)
   //      let forceDict = initializeForces(in: context)
   //      let levelDict = initializeLevels(in: context)
   //      let mechanicDict = initializeMechanics(in: context)
   //      let muscleDict = initializeMuscles(in: context)
   //
   //   }
   
   func getFromJSON(isPreview: Bool = false) -> [Workout] {
      var source = "Workout-Data"
      if isPreview {
         source = "Workout-Data-Preview"
      }
      guard let path = Bundle.main.path(forResource: source, ofType: "json") else {
         fatalError("JSON file not found!")
      }
      // TODO: soon to be deprecated, use "let url = URL(filePath: path)"
      let url = URL(fileURLWithPath: path)
      
      let decoder = JSONDecoder()
      
      do {
         let data = try Data(contentsOf: url)
         let workouts = try decoder.decode([Workout].self, from: data)
         
         return workouts
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   func getCount(for entityName: String, in context: NSManagedObjectContext) -> Int {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
      do {
         let count = try context.count(for: fetchRequest)
         return count
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   func generateExerciseData(in context: NSManagedObjectContext, isPreview: Bool = false) -> Bool {
      let categoryDict = initializeCategories(in: context)
      let equipmentDict = initializeEquipments(in: context)
      let forceDict = initializeForces(in: context)
      let levelDict = initializeLevels(in: context)
      let mechanicDict = initializeMechanics(in: context)
      let muscleDict = initializeMuscles(in: context)
      
      let workouts = getFromJSON(isPreview: isPreview)
      
      var tempExercise = [Exercise]()
      
      for workout in workouts {
         let category = categoryDict[workout.category]!
         let equipmentTemp = workout.equipment ?? "other"
         let equipment = equipmentDict[equipmentTemp]!
         let forceTemp = workout.force ?? "other"
         let force = forceDict[forceTemp]!
         let level = levelDict[workout.level]!
         let mechanicTemp = workout.mechanic ?? "other"
         let mechanic = mechanicDict[mechanicTemp]!
         let muscle = muscleDict[workout.primaryMuscles[0]]!
         
         let newExercise = Exercise.make(in: context,
                                         name: workout.name,
                                         link: "",
                                         note: "",
                                         instructions: workout.instructions,
                                         category: category,
                                         equipment: equipment,
                                         force: force,
                                         level: level,
                                         mechanic: mechanic,
                                         muscle: muscle)
         
         if tempExercise.count < 5 {
            tempExercise.append(newExercise)
         }
      }
      
      // generate preview data
      if isPreview {
         _ = Session.make(in: context, name: "Empty Session", date: Date(), note: "")
         _ = Session.make(in: context, name: "Note Session", date: Date(), note: "Note for morning session. Lorem ipsum dolor ames.")
         let someSession = Session.make(in: context, name: "Some Session", date: Date(), note: "Note for morning session. Lorem ipsum dolor ames.")
         let someEmptySession = Session.make(in: context, name: "Some Empty Session", date: Date(), note: "")
         var activities = [Activity]()
         
         for index in 0 ..< tempExercise.count {
            let newActivity = Activity.make(in: context, note: "notes")
            if index.isMultiple(of: 2) {
               newActivity.note = ""
            }
            newActivity.exercise = tempExercise[index]
            newActivity.order = Int16(index)
            activities.append(newActivity)
         }
         someEmptySession.computedActivities = activities
         activities = [Activity]()
         for index in 0 ..< 3 {
            let newActivity = Activity.make(in: context, note: "notes")
            if index.isMultiple(of: 2) {
               newActivity.note = ""
            }
            newActivity.exercise = tempExercise[index]
            newActivity.order = Int16(index)
            activities.append(newActivity)
            var activitySets = [ActivitySet]()
            for j in 0 ..< 2 {
               let newSet = ActivitySet.make(in: context, rep: 10, value: 20, unit: "kg")
               newSet.setValue(to: 30)
               if j == 1 {
                  newSet.isFailure = true
                  newSet.isBodyWeight = true
               }
               activitySets.append(newSet)
            }
            newActivity.computedActivitySets = activitySets
            
         }
         someSession.computedActivities = activities
      }
      // end of generate preview data
      
      
      do {
         //         try context.performAndWait {
         try context.save()
         //         }
         
         return true
      } catch {
         // Replace this implementation with code to handle the error appropriately.
         // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         let nsError = error as NSError
         fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      
      
   }
   
   func fetchCategory(in context: NSManagedObjectContext) -> [Category] {
      let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
      do {
         let objects = try context.fetch(fetchRequest)
         return objects
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   func fetchEquipment(in context: NSManagedObjectContext) -> [Equipment] {
      let fetchRequest: NSFetchRequest<Equipment> = Equipment.fetchRequest()
      do {
         let objects = try context.fetch(fetchRequest)
         return objects
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   func fetchForce(in context: NSManagedObjectContext) -> [Force] {
      let fetchRequest: NSFetchRequest<Force> = Force.fetchRequest()
      do {
         let objects = try context.fetch(fetchRequest)
         return objects
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   func fetchLevel(in context: NSManagedObjectContext) -> [Level] {
      let fetchRequest: NSFetchRequest<Level> = Level.fetchRequest()
      do {
         let objects = try context.fetch(fetchRequest)
         return objects
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   func fetchMechanic(in context: NSManagedObjectContext) -> [Mechanic] {
      let fetchRequest: NSFetchRequest<Mechanic> = Mechanic.fetchRequest()
      do {
         let objects = try context.fetch(fetchRequest)
         return objects
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   func fetchMuscle(in context: NSManagedObjectContext) -> [Muscle] {
      let fetchRequest: NSFetchRequest<Muscle> = Muscle.fetchRequest()
      do {
         let objects = try context.fetch(fetchRequest)
         return objects
      } catch {
         fatalError(error.localizedDescription)
      }
   }
   
   
}


/*
 - category
 powerlifting
 strength
 stretching
 cardio
 olympic weightlifting
 strongman
 plyometrics
 - equipment
 null
 medicine ball
 dumbbell
 body only
 bands
 kettlebells
 foam roll
 cable
 machine
 barbell
 exercise ball
 e-z curl bar
 other
 - force
 null
 static
 pull
 push
 - level
 beginner
 intermediate
 expert
 - mechanic
 null
 isolation
 compound
 other
 - primaryMuscle
 abdominals
 abductors
 adductors
 biceps
 calves
 chest
 forearms
 glutes
 hamstrings
 lats
 lower back
 middle back
 neck
 quadriceps
 shoulders
 traps
 triceps
 */
