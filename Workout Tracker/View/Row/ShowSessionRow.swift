//
//  ShowSessionRow.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 04/12/23.
//

import SwiftUI

struct ShowSessionRow: View {
   
   @ObservedObject var activity: Activity
   @State private var shouldExpand = true
   
   var body: some View {
      
      Group {
         DisclosureGroup(isExpanded: $shouldExpand) {
            
            LazyVStack(alignment: .leading, spacing: 4) {
               HStack {
                  Spacer()
               }
               .frame(height: 1)
               
               if activity.displayNote != "" {
                  Text(activity.displayNote)
               }
               
               Text("Total: \(activity.displayTotalValues)")
               
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
                           .foregroundColor(.red)
                     }
//                     Spacer()
                  }
               }
            }
            
         } label: {
            Text(activity.displayExerciseName)
               .foregroundColor(Color.green)
               .font(.body.weight(.bold))
               
         }
         .padding(12)
         .modifier(ShowSessionRowViewModifier())
         
      }
      .padding([.leading, .trailing])
   }
   
}
