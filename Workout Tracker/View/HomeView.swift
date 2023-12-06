//
//  HomeView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 06/11/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
   
   @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) private var sessions: FetchedResults<Session>
   
//   init() {
//      UITableView.appearance().showsVerticalScrollIndicator = false
//   }
   
   var body: some View {
      
      NavigationView {
         VStack(alignment: .leading) {
            
            HStack {
               VStack {
                  NavigationLink {
                     NewSessionView()
                  } label: {
                     HStack {
                        Text(Image(systemName: "plus"))
                        Text("Start A New Session")
                     }
                     .foregroundColor(.white)
                  }
               }
               .padding(12)
               .modifier(ActionButton())
            }
            
            HStack {
               Spacer()
            }
            
            Text("Past Session")
               .padding(.top, 16)
               .modifier(SectionHeader())
            
            ScrollView(.vertical, showsIndicators: false) {
               ForEach(sessions) { session in
                  
                  NavigationLink {
                     ShowSessionView(session: session)
                  } label: {
                     HomeSessionRowView(name: session.displayName, date: session.displayDate, activityCount: session.displayActivityCount, totalValue: session.displayTotalValues)
                  }
                  .padding(12)
                  .modifier(HomeSessionRow())
               }
            }
         }
         .navigationTitle("Home")
         .padding([.leading, .trailing])
      }
      
   }
   
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
         .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
   }
}
