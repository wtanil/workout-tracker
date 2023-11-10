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
            VStack {
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<10) {
                            Text("Placeholder \($0)")
                                .foregroundStyle(.white)
                                .font(.body)
                                .frame(width: 200, height: 100)
                                .background(Color.gray)
                        }
                    }
                }
                Spacer()
                NavigationLink("Add new", destination: NewSessionView())
                
                List(sessions) { session in
                    Text(session.name!)
                        
                }
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
