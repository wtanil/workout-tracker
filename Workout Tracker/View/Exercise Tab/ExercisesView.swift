//
//  ExercisesView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 24/11/23.
//

import SwiftUI
import CoreData

struct ExercisesView: View {
   
   @Environment(\.managedObjectContext) var managedObjectContext
   
   @SectionedFetchRequest<String, Exercise>(sectionIdentifier: \.displayTarget, sortDescriptors: [SortDescriptor(\.target), SortDescriptor(\.name)], predicate: nil) private var exerciseSections: SectionedFetchResults<String, Exercise>
   
   @State private var searchText = ""
   @State private var showingEditExerciseView = false
   
   var body: some View {
      NavigationView {
         VStack(alignment: .leading) {
            TextField("Search", text: $searchText)
               .padding(.leading, 16)
               .padding(.trailing, 16)
            
            List {
               ForEach(exerciseSections) { section in
                  Section(section.id) {
                     ForEach(section.filter {
                        isIncluded($0.displayName) }) { exercise in
                           
                           NavigationLink {
                              ShowExerciseView(exercise: exercise)
                           } label: {
                              Text(exercise.displayName)
                           }

                        }
                  }
               }
            }
         }
         .navigationTitle("Exercises")
         .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               navigationBarTrailingItem
            }
         }
         .sheet(isPresented: $showingEditExerciseView) {
            EditExerciseView()
         }
      }
   }
   
   private var navigationBarTrailingItem: some View {
      Button(action: {
         self.showingEditExerciseView.toggle()
         
      }, label: {
         Image(systemName: "plus")
      })
   }
   
   private func isIncluded(_ string: String) -> Bool {
      if searchText == "" {
         return true
      } else {
         return string.lowercased().contains(searchText.lowercased())
      }
   }
}

struct ExercisesView_Previews: PreviewProvider {
   static var previews: some View {
      ExercisesView()
         .preferredColorScheme(.dark)
   }
}
