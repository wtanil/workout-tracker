//
//  EditSessionView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 01/12/23.
//

import SwiftUI
import CoreData

struct EditSessionView: View {
   
   @Environment(\.managedObjectContext) var managedObjectContext
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
   @ObservedObject var session: Session
   @State private var name: String
   @State private var note: String
   @State private var date: Date
   @State var activities = [Activity]()
   
   @State private var showingSelectActivityView = false
   
   init(session: Session) {
      self.session = session
      self._name = State(initialValue: session.displayName)
      self._note = State(initialValue: session.displayNote)
      self._date = State(initialValue: session.date!)
      self._activities = State(initialValue: session.computedActivities)
   }
   
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
                  VStack(alignment: .leading) {
                     ActivityRowView(activity: activity) {
                        let newSet = ActivitySet.make(in: managedObjectContext, rep: 0, value: 0, unit: "kg")
                        var setAsArray = activity.computedActivitySets
                        setAsArray.append(newSet)
                        activity.computedActivitySets = setAsArray
                     } deleteActivityAction: {
                        activities.remove(at: activities.firstIndex(of: activity)!)
                     }
                  }
                  .buttonStyle(.borderless)
               }
            }
         }
      }
      .navigationTitle("Edit Session")
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
   
   private var navigationBarTrailingItem: some View {
      Button(action: {
         
         for index in 0 ..< activities.count {
            activities[index].order = Int16(index)
         }
         session.computedActivities = activities
         session.name = name
         session.date = date
         session.note = note
         
         do {
            try managedObjectContext.save()
         } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
         
         presentationMode.wrappedValue.dismiss()
         
      }, label: {
         Text("Save")
      })
   }
}

struct EditSessionView_Previews: PreviewProvider {
   static var previews: some View {
      
      let context = PersistenceController.preview.container.viewContext
      NewExerciseView()
      EditSessionView(session: Session(context: context))
         .environment(\.managedObjectContext, context)
   }
}
