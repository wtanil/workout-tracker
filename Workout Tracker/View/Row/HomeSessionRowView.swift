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
   var body: some View {
      VStack(alignment: .leading) {
         Text(name)
//            .foregroundColor(.white)
         
         Text(date)
//            .foregroundColor(.white)
            .font(.caption)
         
         Text("Exercises: \(activityCount)")
//            .foregroundColor(.white)
         
      }
   }
}

struct HomeSessionRowView_Previews: PreviewProvider {
   static var previews: some View {
      HomeSessionRowView(name: "name", date: "date", activityCount: "7")
   }
}
