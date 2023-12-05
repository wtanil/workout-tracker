//
//  HomeSessionRowView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 14/11/23.
//

import SwiftUI

struct HomeSessionRowView: View {
   var name: String
   var date: String
   var activityCount: String
   var totalValue: String
   
   var body: some View {
      
      LazyVStack(alignment: .leading) {
         Text(name)
            .font(.body.weight(.bold))
            .foregroundColor(Color.red)
         
         Group {
            Text(date)
               .font(.caption)
            
            Text("Exercises: \(activityCount)")
            Text("Total: \(totalValue)")
         }
         .foregroundColor(Color.primary)
      }
   }
}

struct HomeSessionRowView_Previews: PreviewProvider {
   static var previews: some View {
      HomeSessionRowView(name: "name", date: "date", activityCount: "7", totalValue: "100 kg")
   }
}
