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
         
         ScrollView(.vertical, showsIndicators: false) {
            ForEach(session.activitiesAsArray) { activity in
               ShowSessionRow(activity: activity)
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
      .alert(isPresented: $showingDeleteAlert, content: { deleteAlert })
      
   }
   
   private var navigationBarTrailingItem: some View {
      
      HStack {
         NavigationLink("Edit", destination: EditSessionView(session: session))
         
         Button() {
            self.showingDeleteAlert.toggle()
         } label: {
            Text("Delete")
         }
      }
   }
   
   private var deleteAlert: Alert {
      Alert(title: Text("Warning"),
            message: Text("Do you want to delete?"),
            primaryButton: .destructive(Text("Delete"),
                                        action: deleteMeasurement),
            secondaryButton: .default(Text("Cancel"))
      )
   }
   
   func deleteMeasurement() {
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

struct SessionView_Previews: PreviewProvider {
   static var previews: some View {
      
      let context = PersistenceController.preview.container.viewContext
      ShowSessionView(session: Session(context: context))
         .environment(\.managedObjectContext, context)
   }
}
