//
//  NewSessionView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 06/11/23.
//

import SwiftUI
import CoreData

struct NewSessionView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name: String = ""
    @State private var note: String = ""
    @State private var date: Date = Date()
    @State var activities = [Activity]()
    
    var body: some View {
        VStack {
            Form {
                Section() {
                    TextField("Name", text: $name)
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    TextField("Notes", text: $note)
                }
                Section("Exercises") {
                    NavigationLink("Add a new exercise", destination: SelectActivitiesView(activities: $activities)
                    )
                    
                    if !activities.isEmpty {
                        List(activities) { activity in
                            HStack {
                                Text(activity.exercise!.displayName)
                                Spacer()
                                Button(action: {
                                    let indexToDelete = activities.firstIndex(of: activity)
                                    activities.remove(at: indexToDelete!)
                                }, label: {
                                    Image(systemName: "trash")
                                })
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("New Session")
    }
}

struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
