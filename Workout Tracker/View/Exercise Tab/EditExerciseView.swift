//
//  EditExerciseView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 24/11/23.
//

import SwiftUI

struct EditExerciseView: View {
   
   @Environment(\.managedObjectContext) var managedObjectContext
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
   @State private var name: String = ""
   @State private var category: Category = .other
   @State private var target: Target = .other
   @State private var link: String = ""
   @State private var note: String = ""
   
    var body: some View {
       NavigationView {
          Form {
             Section {
                TextField("Name", text: $name)
                TextField("Link", text: $link)
                TextField("Note", text: $note)
             }
             
             Section {
                Picker("Category", selection: $category) {
                   ForEach(Category.allCases) { category in
                      Text(category.rawValue)
                   }
                }
                Picker("Target", selection: $target) {
                   ForEach(Target.allCases) { target in
                      Text(target.rawValue)
                   }
                }
             }
          }
          .navigationTitle("New Exercise")
          .toolbar {
             ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
             }
          }
       }
    }
   
   private var navigationBarTrailingItem: some View {
      Button(action: {
         let newExercise = Exercise.make(in: managedObjectContext, name: name, category: category.rawValue, target: target.rawValue, link: link, note: note)
         
         do {
            try managedObjectContext.save()
         } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
         }
         
         presentationMode.wrappedValue.dismiss()
         
      }, label: {
         Text("Save")
      })
   }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
       
       let context = PersistenceController.preview.container.viewContext
       EditExerciseView()
          .preferredColorScheme(.dark)
          .environment(\.managedObjectContext, context)
    }
}
