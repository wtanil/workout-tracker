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
//                ScrollView(.horizontal) {
//                    HStack(spacing: 20) {
//                        ForEach(0..<10) {
//                            Text("Placeholder \($0)")
//                                .foregroundStyle(.white)
//                                .font(.body)
//                                .frame(width: 200, height: 100)
//                                .background(Color.gray)
//                        }
//                    }
//                }
                
                List {
                    Section {
                        NavigationLink("Start A New Session", destination: NewSessionView())
                            .buttonStyle(.borderedProminent)
                    }
                    Section("Past Sessions") {
                        ForEach(sessions) { session in
                            VStack(alignment: .leading) {
                                Text(session.displayDate)
                                Text(session.displayName)
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
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