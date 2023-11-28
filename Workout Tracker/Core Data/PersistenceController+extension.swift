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
   
   
   func initialize(for context: NSManagedObjectContext) {
      
      let categoryDict = initializeCategories(in: context)
      let equipmentDict = initializeEquipments(in: context)
      let forceDict = initializeForces(in: context)
      let levelDict = initializeLevels(in: context)
      let mechanicDict = initializeMechanics(in: context)
      let muscleDict = initializeMuscles(in: context)
      print(categoryDict)
      print(equipmentDict)
      print(forceDict)
      print(levelDict)
      print(mechanicDict)
      print(muscleDict)
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
