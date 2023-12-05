//
//  ActivityRowView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 13/11/23.
//

import SwiftUI

struct ActivityRowView: View {
   
   @ObservedObject var activity: Activity
   
//   @State var activityUnit: String = ActivityUnit.kg.rawValue
   @State var activityUnit: String
   
   var newActivitySetAction: () -> ()
   var deleteActivityAction: () -> ()
   
   init(activity: Activity, newActivitySetAction: @escaping () -> (), deleteActivityAction: @escaping () -> ()) {
      self.activity = activity
      self.activityUnit = activity.displayActivitySetUnit
      self.newActivitySetAction = newActivitySetAction
      self.deleteActivityAction = deleteActivityAction
   }
   
   var body: some View {
      VStack(alignment: .leading) {
         HStack {
            Button(action: {
               newActivitySetAction()
            }, label: {
               Text(Image(systemName: "plus")) + Text(" Add set")
            })
            
            Picker("Unit",
                   selection: $activityUnit
            ) {
               ForEach(ActivityUnit.allCases) { unit in
                  Text(unit.rawValue)
               }
            }
            .labelsHidden()
            .frame(width: 72)
            .pickerStyle(.menu)
            
            Spacer()
            Button(role: .destructive, action: {
               deleteActivityAction()
            }, label: {
               Image(systemName: "trash")
            })
         }
         ForEach(activity.activitySetsAsArray) { activitySet in
            Divider()
            HStack(alignment: .center) {
               ActivitySetRowView(activity: activity, activitySet: activitySet, activityUnit: $activityUnit)
            }
         }
      }
   }
}

struct ActivityRowView_Previews: PreviewProvider {
   static var previews: some View {
      let context = PersistenceController.preview.container.viewContext
      ActivityRowView(activity: Activity.make(in: context, note: "")) {
         print("add")
      } deleteActivityAction: {
         print("delete")
      }
         .environment(\.managedObjectContext, context)
   }
}
