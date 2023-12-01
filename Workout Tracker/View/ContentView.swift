//
//  ContentView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 30/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
   var body: some View {
      TabView {
         HomeView()
            .tabItem {
               Image(systemName: "house")
               Text("Home")
            }
         ExercisesView()
            .tabItem {
               Image(systemName: "figure.walk")
               Text("Exercises")
            }
//         Text("Setting Placeholder")
//            .tabItem {
//               Image(systemName: "gear")
//               Text("Setting")
//
//            }
      }
   }
}

struct ContentView_Previews: PreviewProvider {
   static var previews: some View {
      let persistenceController = PersistenceController.preview
      let viewContext = persistenceController.container.viewContext
      
      let _ = persistenceController.getCount(for: "Exercise", in: viewContext) == 0 ? persistenceController.generateExerciseData(in: viewContext, isPreview: true) : false
      
      ContentView()
         .environment(\.managedObjectContext, viewContext)
      
   }
}
