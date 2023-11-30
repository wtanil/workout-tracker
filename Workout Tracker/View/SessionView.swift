//
//  SessionView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 14/11/23.
//

import SwiftUI

struct SessionView: View {
   
   var session: Session
   
   var body: some View {
      VStack(alignment: .leading, spacing: 8) {
         
         Text("\(session.displayDate)")
            .font(.title3)
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
         Text("\(session.displayNote)")
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
         
         List(session.activitiesAsArray) { activity in
            Section(activity.displayExerciseName) {
               #warning("Check why even if total value is 0, it is still showed")
               if activity.displayTotalValue != "-" {
                  Text("Total: \(activity.displayTotalValue)")
               }
               
               if activity.displayNote != "" {
                  Text(activity.displayNote)
                     .font(.caption)
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
                        Image(systemName: "figure.strengthtraining.functional")
                           .foregroundColor(.blue)
                     }
                     if activitySet.isFailure {
                        Image(systemName: "flame.fill")
                           .foregroundColor(.blue)
                     }
                     
                  }
                  //                        .padding(.leading, 16)
               }
            }
         }
         .listStyle(.sidebar)
         
      }
      .navigationTitle(session.displayName)
      
   }
}

struct SessionView_Previews: PreviewProvider {
   static var previews: some View {
      
      let context = PersistenceController.preview.container.viewContext
      SessionView(session: Session(context: context))
         .environment(\.managedObjectContext, context)
   }
}
