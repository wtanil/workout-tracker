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
                //                .frame(width: 48)
                
                Text("x")
                
                TextField("Val",
                          value: Binding<Double>(
                            get: { activitySet.value },
                            set: {
                                activitySet.setValue(to: $0)
                            }),
                          format: .number)
                .keyboardType(.decimalPad)
                //                .frame(width: 48)
                
                Picker("Unit",
                       selection: Binding<String>(
                        get: { activitySet.displayUnit },
                        set: {
                            activitySet.setUnit(to: $0)
                        })
                ) {
                    ForEach(ActivityUnit.allCases) { unit in
                        Text(unit.rawValue)
                    }
                    
                }
                .labelsHidden()
                .frame(width: 72)
                .pickerStyle(.menu)
                
                Toggle(isOn: Binding<Bool>(
                    get: { activitySet.isBodyWeight },
                    set: { _ in activitySet.isBodyWeight.toggle() }
                )) {
                    Image(systemName: "figure.strengthtraining.functional") }
                .toggleStyle(.button)
//                .tint(.blue)
                
                Toggle(isOn: Binding<Bool>(
                    get: { activitySet.isFailure },
                    set: { _ in activitySet.isFailure.toggle() }
                )) {
                    Image(systemName: "flame")
                }
                .toggleStyle(.button)
//                .tint(.blue)
            }
        }
    }
}

struct ActivitySetRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = PersistenceController.preview.container.viewContext
        ActivitySetRowView(activity: Activity(context: context), activitySet: ActivitySet(context: context))
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, context)
    }
}
