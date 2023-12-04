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
                           .foregroundColor(.white)
                        Text("Start A New Session")
                           .foregroundColor(.white)
                     }
                  }
               }
               .padding()
               .modifier(ActionButton())
            }
            
            Text("Past Session")
               .padding(.top, 16)
               .modifier(SectionHeader())
            
            List {
               ForEach(sessions) { session in
                  
                  NavigationLink {
                     ShowSessionView(session: session)
                  } label: {
                     HomeSessionRowView(name: session.displayName, date: session.displayDate, activityCount: session.displayActivityCount)
                  }
                  .padding()
                  .modifier(HomeSessionRow())
               }
            }
            .listStyle(.plain)
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
