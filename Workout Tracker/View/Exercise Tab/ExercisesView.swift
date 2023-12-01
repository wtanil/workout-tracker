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
   
   @SectionedFetchRequest<String, Exercise>(sectionIdentifier: \.displayMuscle, sortDescriptors: [SortDescriptor(\.muscle!.name), SortDescriptor(\.name)], predicate: nil) private var exerciseSections: SectionedFetchResults<String, Exercise>
   
   @State private var searchText = ""
   @State private var showingNewExerciseView = false
   @State private var showingDeleteAlert = false
   @State private var exerciseToDelete: Exercise? = nil
   
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
                           .swipeActions {
                              Button("Delete") {
                                 self.exerciseToDelete = exercise
                                 self.showingDeleteAlert.toggle()
                              }
                              .tint(.red)
                           }

                        }
                        .confirmationDialog("Are you sure?", isPresented: $showingDeleteAlert) {
                           Button("Delete", role: .destructive) {
                              deleteAction()
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
         .sheet(isPresented: $showingNewExerciseView) {
            NewExerciseView()
         }
      }
   }
   
   private var navigationBarTrailingItem: some View {
      Button(action: {
         self.showingNewExerciseView.toggle()
         
      }, label: {
         Image(systemName: "plus")
      })
   }
   
   private func deleteAction() {
      Exercise.delete(exercise: exerciseToDelete!, in: managedObjectContext)
      do {
         try managedObjectContext.save()
      } catch {
         let nsError = error as NSError
         fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      
      self.exerciseToDelete = nil
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
   }
}
