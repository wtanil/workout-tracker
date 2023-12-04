//
//  SessionView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 14/11/23.
//

import SwiftUI

struct ShowSessionView: View {
   
   @ObservedObject var session: Session
   
   @State private var showingNote: Bool = false
   
   var body: some View {
      VStack(alignment: .leading, spacing: 8) {
         
         Text("\(session.displayDate)")
            .font(.title3)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
         
         if session.displayNote != "" {
            Toggle(showingNote ? "note \(Image(systemName: "chevron.up"))" : "note \(Image(systemName: "chevron.down"))", isOn: $showingNote)
               .toggleStyle(.button)
               .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
         }
         
         if showingNote {
            Text("\(session.displayNote)")
               .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
         }
            
         
         List(session.activitiesAsArray) { activity in
            Section(activity.displayExerciseName) {

               if activity.displayTotalValue != "-" {
                  Text("Total: \(activity.displayTotalValue)")
               }
               
               if activity.displayNote != "" {
                  Text(activity.displayNote)
               }
               ForEach(activity.activitySetsAsArray) {
                  activitySet in
                  HStack {
                     Image(systemName: "circle.fill")
                        .imageScale(.small)
                        .foregroundColor(.green)
                     Text("\(activitySet.repAsInt)")
                     Text("x")
                     Text("\(activitySet.displayValue)")
                     Text(activitySet.displayUnit)
                     (Text(Image(systemName: "scalemass")) + Text(": \(activitySet.displayTotalValue)"))
                     Text(activitySet.displayUnit)
                     if activitySet.isBodyWeight {
                        Image(systemName: "person.fill")
                           .foregroundColor(.blue)
                     }
                     if activitySet.isFailure {
                        Image(systemName: "flame.fill")
                           .foregroundColor(.blue)
                     }
                     
                  }
               }
            }
         }
         .listStyle(.sidebar)
         
      }
      .navigationTitle(session.displayName)
      .toolbar {
         ToolbarItem(placement: .navigationBarTrailing) {
            navigationBarTrailingItem
         }
      }
      
   }
   
   private var navigationBarTrailingItem: some View {
      
      NavigationLink("Edit", destination: EditSessionView(session: session))
      
      // to delete, start async thread, then go back
      
//      Menu {
//
//         Divider()
//         Button("Delete", role: .destructive) {
//            print("asdf")
//         }
//      } label: {
//         Label("", systemImage: "ellipsis")
//      }
   }
}

struct SessionView_Previews: PreviewProvider {
   static var previews: some View {
      
      let context = PersistenceController.preview.container.viewContext
      ShowSessionView(session: Session(context: context))
         .environment(\.managedObjectContext, context)
   }
}
