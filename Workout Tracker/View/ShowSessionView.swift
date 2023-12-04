//
//  SessionView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 14/11/23.
//

import SwiftUI

struct ShowSessionView: View {
   
   @ObservedObject var session: Session
   
   @State private var showingNote: Bool = false
   
   var body: some View {
      VStack(alignment: .leading) {
         
            VStack(alignment: .leading) {
               
               Text("\(session.displayDate)")
                  .font(.title3)
               
               if session.displayNote != "" {
                  Toggle(showingNote ? "Note \(Image(systemName: "chevron.up"))" : "Note \(Image(systemName: "chevron.down"))", isOn: $showingNote.animation())
                     .toggleStyle(.button)
                     .tint(.blue)
                     .cornerRadius(16, antialiased: true)
                     .overlay(
                        RoundedRectangle(cornerRadius: 16)
                           .inset(by: 0)
                           .strokeBorder(.blue, lineWidth: 2, antialiased: true)
                     )
                     
               }
               
               if showingNote {
                  Text("\(session.displayNote)")
               }
               
               HStack { Spacer() }
            }
            
         .padding([.leading, .trailing])
         
         GeometryReader { geometry in
            ScrollView {
               ForEach(session.activitiesAsArray) { activity in
                  ShowSessionRow(activity: activity)
               }
               .frame(width: geometry.size.width)
            }
         }
         
         
         
         Spacer()
         
      }
      .navigationTitle(session.displayName)
      
      .toolbar {
         ToolbarItem(placement: .navigationBarTrailing) {
            navigationBarTrailingItem
         }
      }
      
   }
   
   private var navigationBarTrailingItem: some View {
      
      NavigationLink("Edit", destination: EditSessionView(session: session))
      
      // to delete, start async thread, then go back
      
      //      Menu {
      //
      //         Divider()
      //         Button("Delete", role: .destructive) {
      //            print("asdf")
      //         }
      //      } label: {
      //         Label("", systemImage: "ellipsis")
      //      }
   }
}

struct SessionView_Previews: PreviewProvider {
   static var previews: some View {
      
      let context = PersistenceController.preview.container.viewContext
      ShowSessionView(session: Session(context: context))
         .environment(\.managedObjectContext, context)
   }
}
