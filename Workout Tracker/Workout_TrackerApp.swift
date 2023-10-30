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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
