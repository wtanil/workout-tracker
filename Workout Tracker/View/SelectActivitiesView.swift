//
//  SelectActivitiesView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 08/11/23.
//

import SwiftUI
import CoreData

struct SelectActivitiesView: View {
    
    // future: solution to avoid using environment (donny walsh and paul hudson methods
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // shorts idea: (on preview canvas) why entity not found when xcdatamodel changed
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)], predicate: nil) private var exercises: FetchedResults<Exercise>
    @Binding var activities: [Activity]
    // shorts idea: using dict and uuid to keep track
    @State private var dict = [UUID: Activity]() // exercise ID: new activity
    @State private var searchText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section {
                    TextField("Search", text: $searchText)
                        .onChange(of: searchText) { newValue in
                            if newValue == "" {
                                exercises.nsPredicate = nil
                            } else {
                                exercises.nsPredicate = NSPredicate(format: "name CONTAINS[cd] %@", newValue)
                            }
                        }
                }
                
                // shorts idea: fallback is good
                if exercises.isEmpty {
                    // add new exercise
                    Text("There is no exercise")
                }
                else {
                    ForEach(exercises) { exercise in
                        getListRow(exercise: exercise)
                    }
                }
            }
        }
        .navigationTitle("Select exercises")
//        .searchable(text: $searchText)
    }
    
    private func getListRow(exercise: Exercise) -> some View {
        Button(action: {
            if let activity = dict[exercise.id!] {
                dict.removeValue(forKey: exercise.id!)
                let indexToDelete = activities.firstIndex(of: activity)
                activities.remove(at: indexToDelete!)
                
            } else {
                let newActivity = Activity.make(in: managedObjectContext, note: "")
                newActivity.exercise = exercise
                activities.append(newActivity)
                dict[exercise.id!] = newActivity
                
            }
        }, label: {
            HStack {
                Text(exercise.displayName)
                Spacer()
                if dict[exercise.id!] != nil {
                    Image(systemName: "checkmark")
                }
            }
        })
    }
    
}

struct SelectActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        SelectActivitiesView(activities: .constant([Activity]()))
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, context)
    }
}
