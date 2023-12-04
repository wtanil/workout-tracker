//
//  ShowSessionRow.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 04/12/23.
//

import SwiftUI

struct ShowSessionRow: View {
   
   var activity: Activity
   @State private var shouldExpand = true
   
   var body: some View {
      
      Group {
         DisclosureGroup(isExpanded: $shouldExpand) {
            
            VStack(alignment: .leading, spacing: 8) {
               HStack {
                  Spacer()
               }
               
               if activity.displayNote != "" {
                  Text(activity.displayNote)
               }
               
               if activity.displayTotalValue != "-" {
                  Text("Total: \(activity.displayTotalValue)")
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
//                     Spacer()
                  }
               }
            }
            
         } label: {
            Text(activity.displayExerciseName)
               
         }
         .padding()
         .background(Color.red.opacity(0.1))
         .cornerRadius(16, antialiased: true)
         .overlay(
            RoundedRectangle(cornerRadius: 16)
               .inset(by: 0)
               .strokeBorder(.red, lineWidth: 2, antialiased: true)
         )
         
      }
      .padding([.leading, .trailing])
   }
   
}

struct ShowSessionRow_Previews: PreviewProvider {
   static var previews: some View {
      let context = PersistenceController.preview.container.viewContext
      ShowSessionRow(activity: Activity(context: context))
   }
}
