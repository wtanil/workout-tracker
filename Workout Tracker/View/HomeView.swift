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
                
                List {
                    Section {
                        NavigationLink("Start A New Session", destination: NewSessionView())
                    }
                    Section("Past Sessions") {
                        ForEach(sessions) { session in
                            
                            NavigationLink {
                                SessionView(session: session)
                            } label: {
                                HomeSessionRowView(name: session.displayName, date: session.displayDate)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Home")
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}