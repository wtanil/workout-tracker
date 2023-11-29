//
//  ShowExerciseView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 24/11/23.
//

import SwiftUI

struct ShowExerciseView: View {
   
   var exercise: Exercise
   
   var body: some View {
      VStack {
         HStack {
            Text("Target: \(exercise.displayMuscle)")
            Spacer()
         }
         
         HStack {
            Text(exercise.displayCategory)
            Spacer()
         }
         
         HStack {
            Text("Link: \(exercise.displayLink)")
            Spacer()
         }
         
         HStack {
            Text("Note: \(exercise.displayNote)")
            Spacer()
         }
         
         List {
            ForEach(["Placeholder activity 1", "Placeholder activity 2", "Placeholder activity 3", "Placeholder activity 4"], id: \.self) { activity in
               Text(activity)
            }
            
         }
         .listStyle(.plain)
         
         
         Spacer()
      }
      .padding(.trailing, 16)
      .padding(.leading, 16)
      .navigationTitle(exercise.displayName)
   }
}

struct ShowExerciseView_Previews: PreviewProvider {
   static var previews: some View {
      let context = PersistenceController.preview.container.viewContext
      ShowExerciseView(exercise: Exercise.init(context: context))
         .preferredColorScheme(.dark)
         .environment(\.managedObjectContext, context)
   }
}
