//
//  SelectActivitiesView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 08/11/23.
//

import SwiftUI
import CoreData

struct SelectActivitiesView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var exercises: FetchedResults<Exercise>
    @Binding var activities: [Activity]
    @State private var dict = [UUID: Activity]() // exercise ID: new activity
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if exercises.isEmpty {
                // add new exercise
                Text("There is no exercise")
            }
            else {
                List(exercises) { exercise in
                    
                    Button(action: {
                        if let activity = dict[exercise.id!] {
                            dict.removeValue(forKey: exercise.id!)
                            let indexToDelete = activities.firstIndex(of: activity)
                            activities.remove(at: indexToDelete!)
                            
                        } else {
                            let newActivity = Activity.make(in: managedObjectContext, notes: "")
                            newActivity.exercise = exercise
                            activities.append(newActivity)
                            dict[exercise.id!] = newActivity
                        }
                    }, label: {
                        HStack {
                            Text(exercise.name ?? "Unknown")
                            Spacer()
                            if dict[exercise.id!] != nil {
                                Image(systemName: "checkmark")
                            }
                            
                        }
                    })
                }
            }
        }
        .navigationTitle("Select exercises")
    }
}

struct SelectActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SelectActivitiesView(activities: .constant([Activity]()))
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
