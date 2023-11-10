//
//  HomeView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 06/11/23.
//

import SwiftUI

struct HomeView: View {
    
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
                List {
                    ForEach(0 ..< 10) {
                        if $0 == 0 {
                            NavigationLink("Add new", destination: NewSessionView())
                        }
                        Text("Placeholder \($0)")
                            .font(.body)
                            .frame(width: 200, height: 50)
                            .background(Color.gray)
                    }
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
