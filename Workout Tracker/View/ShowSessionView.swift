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
      VStack(alignment: .leading) {
         
            VStack(alignment: .leading) {
               
               Text("\(session.displayDate)")
                  .font(.title3)
               
               if session.displayNote != "" {
                  Toggle(showingNote ? "Note \(Image(systemName: "chevron.up"))" : "Note \(Image(systemName: "chevron.down"))", isOn: $showingNote.animation())
                     .toggleStyle(.button)
                     .cornerRadius(16, antialiased: true)
                     .overlay(
                        RoundedRectangle(cornerRadius: 16)
                           .inset(by: 0)
                           .strokeBorder(.red, lineWidth: 2, antialiased: true)
                     )
               }
               
               if showingNote {
                  Text("\(session.displayNote)")
               }
               
               HStack { Spacer() }
            }
            
         .padding([.leading, .trailing])
         
         ForEach(session.activitiesAsArray) { activity in
            ShowSessionRow(activity: activity)
            
         }
         
         Spacer()
         
//         List(session.activitiesAsArray) { activity in
//            Section(activity.displayExerciseName) {
//
//               if activity.displayTotalValue != "-" {
//                  Text("Total: \(activity.displayTotalValue)")
//                     .padding([.leading, .trailing])
//               }
//
//               if activity.displayNote != "" {
//                  Text(activity.displayNote)
//                     .padding([.leading, .trailing])
//
//               }
//               ForEach(activity.activitySetsAsArray) {
//                  activitySet in
//                  HStack {
//                     Image(systemName: "circle.fill")
//                        .imageScale(.small)
//                        .foregroundColor(.green)
//                     Text("\(activitySet.repAsInt)")
//                     Text("x")
//                     Text("\(activitySet.displayValue)")
//                     Text(activitySet.displayUnit)
//                     (Text(Image(systemName: "scalemass")) + Text(": \(activitySet.displayTotalValue)"))
//                     Text(activitySet.displayUnit)
//                     if activitySet.isBodyWeight {
//                        Image(systemName: "person.fill")
//                           .foregroundColor(.blue)
//                     }
//                     if activitySet.isFailure {
//                        Image(systemName: "flame.fill")
//                           .foregroundColor(.blue)
//                     }
//
//                  }
//
//                  .padding([.leading, .trailing])
//
//               }
//            }
//            .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
//         }
//         .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
//
//         .listStyle(.sidebar)
         
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
