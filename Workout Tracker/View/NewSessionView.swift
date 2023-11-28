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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var name: String = "New Session"
    @State private var note: String = ""
    @State private var date: Date = Date()
    @State var activities = [Activity]()
    
    @State private var showingSelectActivityView = false
    
    var body: some View {
        Form {
            Section() {
                TextField("Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                TextField("Notes", text: $note)
            }
            Section {
                showingSelectActivityButton
            }
            
            if !activities.isEmpty {
                ForEach(activities) { activity in
                    Section(activity.displayExerciseName) {
                        VStack(alignment: .center) {
                            HStack {
                                getNewActivitySetButton(activity: activity)
                                Spacer()
                                getDeleteActivityButton(activity: activity)
                            }
                            
                            ActivityRowView(activity: activity)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
        .navigationTitle("New Session")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
            }
        }
        .sheet(isPresented: $showingSelectActivityView) {
            SelectActivitiesView(activities: $activities)
        }
        
    }
    
    private var showingSelectActivityButton: some View {
        Button(action: {
            self.showingSelectActivityView.toggle()
        }, label: {
            Text("Add a new exercise")
        })
    }
    
    private func getNewActivitySetButton(activity: Activity) -> some View {
        Button(action: {
            let newSet = ActivitySet.make(in: managedObjectContext, rep: 0, value: 0, unit: "kg")
            var setAsArray = activity.computedActivitySets
            setAsArray.append(newSet)
            activity.computedActivitySets = setAsArray
        }, label: {
            Text(Image(systemName: "plus")) + Text(" Add set")
        })
    }
    
    private func getDeleteActivityButton(activity: Activity) -> some View {
        Button(role: .destructive, action: {
            let indexToDelete = activities.firstIndex(of: activity)
            activities.remove(at: indexToDelete!)
        }, label: {
            Image(systemName: "trash")
        })
    }
    
    private var navigationBarTrailingItem: some View {
        Button(action: {
            let newSession = Session.make(in: managedObjectContext, name: name, date: date, note: note)
            for index in 0 ..< activities.count {
                activities[index].order = Int16(index)
            }
            newSession.computedActivities = activities
            
            do {
                try managedObjectContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            presentationMode.wrappedValue.dismiss()
            
        }, label: {
            Text("Finish")
        })
    }
}

struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}