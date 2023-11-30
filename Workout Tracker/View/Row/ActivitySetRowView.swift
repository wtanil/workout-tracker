//
//  ActivitySetRowView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 13/11/23.
//

import SwiftUI

struct ActivitySetRowView: View {
   
   @ObservedObject var activity: Activity
   @ObservedObject var activitySet: ActivitySet
   @Binding var activityUnit: String
   
   var body: some View {
      VStack(alignment: .leading) {
         HStack(alignment: .center) {
            TextField("Rep",
                      value: Binding<Int>(
                        get: { activitySet.repAsInt },
                        set: {
                           activitySet.setRep(to: $0)
                        }),
                      format: .number)
            .keyboardType(.decimalPad)
            .frame(width: 48)
            
            Text("x")
            
            TextField("Val",
                      value: Binding<Double>(
                        get: { activitySet.value },
                        set: {
                           activitySet.setValue(to: $0)
                        }),
                      format: .number)
            .keyboardType(.decimalPad)
            .frame(width: 48)
            
            Text(activityUnit).onChange(of: activityUnit) { newValue in
               activitySet.setUnit(to: newValue)
            }
            
            if activitySet.isFailure {
               Image(systemName: "flame")
                  .foregroundColor(.red)
            }
            if activitySet.isBodyWeight {
               Image(systemName: "figure.strengthtraining.functional")
                  .foregroundColor(.blue)
            }
            
            Spacer()
            Menu {
               Button("Body Weight") {
                  activitySet.isBodyWeight.toggle()
               }
               Button("Failure") {
                  activitySet.isFailure.toggle()
               }
               Divider()
               Button("Delete", role: .destructive) {
                  activity.remove(activitySet)
               }
            } label: {
               Label("", systemImage: "ellipsis")
            }
         }
      }
   }
}

struct ActivitySetRowView_Previews: PreviewProvider {
   static var previews: some View {
      
      let context = PersistenceController.preview.container.viewContext
      ActivitySetRowView(activity: Activity(context: context), activitySet: ActivitySet(context: context), activityUnit: .constant("kg"))
         .environment(\.managedObjectContext, context)
   }
}
