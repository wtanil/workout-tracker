//
//  SessionView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 14/11/23.
//

import SwiftUI

struct ShowSessionView: View {
   @Environment(\.managedObjectContext) var managedObjectContext
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
   @ObservedObject var session: Session
   
   @State private var showingNote: Bool = false
   @State private var showingDeleteAlert: Bool = false
   
   var body: some View {
      VStack(alignment: .leading) {
         
         VStack(alignment: .leading) {
            
            Text("\(session.displayName)")
               .modifier(SectionHeader())
            
            Text("\(session.displayDate)")
            //                  .font(.body)
            
            if session.displayNote != "" {
               Toggle(showingNote ? "Note \(Image(systemName: "chevron.up"))" : "Note \(Image(systemName: "chevron.down"))", isOn: $showingNote.animation())
                  .modifier(AccessoryToggle())
            }
            
            if showingNote {
               Text("\(session.displayNote)")
            }
            
            HStack { Spacer() }
         }
         
         .padding([.leading, .trailing])
         
         if session.activityCount == 0 {

            Group {
               VStack {
                  NavigationLink {
                     EditSessionView(session: session)
                  } label: {
                     HStack {
                        Text("Add more exercises!")
                     }
                     .foregroundColor(.white)
                  }
               }
               .padding(10)
               .modifier(ActionButton())
            }
            .padding([.leading, .trailing])
            
            

         } else {
            ScrollView(.vertical, showsIndicators: false) {
               ForEach(session.activitiesAsArray) { activity in
                  ShowSessionRow(activity: activity)
               }
            }
         }
         
         
         Spacer()
         
      }
      .navigationTitle("Session")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
         ToolbarItem(placement: .navigationBarTrailing) {
            navigationBarTrailingItem
         }
      }
      .alert(isPresented: $showingDeleteAlert, content: { deleteAlert })
      .onAppear(perform: {
         managedObjectContext.rollback()
      })
      
   }
   
   private var navigationBarTrailingItem: some View {
      
      HStack {
         Button() {
            self.showingDeleteAlert.toggle()
         } label: {
            Image(systemName: "trash")
         }
         
         NavigationLink("Edit", destination: EditSessionView(session: session))
      }
   }
   
   private var deleteAlert: Alert {
      Alert(title: Text("Warning"),
            message: Text("Are you sure you want to delete \"\(session.displayName)\"? This action cannot be undone."),
            primaryButton: .destructive(Text("Delete"),
                                        action: deleteSession),
            secondaryButton: .cancel(Text("Cancel"))
      )
   }
   
   func deleteSession() {
      managedObjectContext.delete(session)
      do {
         try managedObjectContext.save()
      } catch {
         let nsError = error as NSError
         fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      
      presentationMode.wrappedValue.dismiss()
   }
}
