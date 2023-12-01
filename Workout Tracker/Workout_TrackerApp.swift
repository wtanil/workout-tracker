//
//  Workout_TrackerApp.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 30/10/23.
//

import SwiftUI

@main
struct Workout_TrackerApp: App {
   let persistenceController = PersistenceController.shared
   // Generate Exercises data from data set, count is used to make sure it is generated once
   let temp = PersistenceController.shared.getCount(for: "Level", in: PersistenceController.shared.container.viewContext) == 0 ? PersistenceController.shared.generateExerciseData(in: PersistenceController.shared.container.viewContext) : false
   
   var body: some Scene {
      WindowGroup {
         ContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
      }
   }
}
