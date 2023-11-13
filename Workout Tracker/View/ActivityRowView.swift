//
//  ActivityRowView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 13/11/23.
//

import SwiftUI

struct ActivityRowView: View {
    
    @ObservedObject var activity: Activity
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(activity.activitySetsAsArray) { activitySet in
                Divider()
                HStack(alignment: .center) {
                    ActivitySetRowView(activity: activity, activitySet: activitySet)
                    Spacer()
                    Button(role: .destructive, action: {
                        activity.remove(activitySet)
                    }, label: {
                        Image(systemName: "minus")
                    })
                    .buttonStyle(.borderless)
                    
                }
            }
        }
    }
}

struct ActivityRowView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        ActivityRowView(activity: Activity.make(in: context, note: ""))
            .environment(\.managedObjectContext, context)
    }
}
