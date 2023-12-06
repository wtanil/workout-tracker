//
//  ShowExerciseView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 24/11/23.
//

import SwiftUI

struct ShowExerciseView: View {
   
   var exercise: Exercise
   
   @State private var showingInstructions = false
   
   var body: some View {
      ScrollView(.vertical, showsIndicators: false) {
         VStack(alignment: .leading) {
            Text(exercise.displayName)
               .modifier(SectionHeader())
            Group {
               Text("Level: \(exercise.displayLevel)")
               Text("Force: \(exercise.displayForce)")
               Text("Target: \(exercise.displayMuscle)")
               Text("Category: \(exercise.displayCategory)")
               Text("Equipment: \(exercise.displayEquipment)")
               Text("Mechanic: \(exercise.displayMechanic)")
               if exercise.displayLink != "" {
                  Text("Link: \(exercise.displayLink)")
               }
               if exercise.displayNote != "" {
                  Text("Note: \(exercise.displayNote)")
               }
            }
            
            Toggle(showingInstructions ? "Instructions \(Image(systemName: "chevron.up"))" : "Instructions \(Image(systemName: "chevron.down"))", isOn: $showingInstructions.animation())
               .modifier(AccessoryToggle())
            
            if showingInstructions {
               VStack(alignment: .leading) {
                  ForEach(exercise.instructionsAsArray, id: \.self) { instruction in
                     HStack(alignment: .top) {
                        Image(systemName: "circle")
                           .imageScale(.small)
                        Text("\(instruction)")
                     }
                  }
               }
            }
            HStack {
               Spacer()
            }
            Spacer()
         }
      }
      .padding([.leading, .trailing])
      .navigationTitle("Exercise")
   }
}
