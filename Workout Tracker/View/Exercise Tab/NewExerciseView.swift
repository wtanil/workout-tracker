//
//  EditExerciseView.swift
//  Workout Tracker
//
//  Created by William Suryadi Tanil on 24/11/23.
//

import SwiftUI

struct NewExerciseView: View {
   
   @Environment(\.managedObjectContext) var managedObjectContext
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   private var persistenceController = PersistenceController.current!
   
   @State private var name: String = ""
   @State private var link: String = ""
   @State private var note: String = ""
   
   private var categories: [Category]
   @State private var category: Category
   private var equipments: [Equipment]
   @State private var equipment: Equipment
   private var forces: [Force]
   @State private var force: Force
   private var levels: [Level]
   @State private var level: Level
   private var mechanics: [Mechanic]
   @State private var mechanic: Mechanic
   private var muscles: [Muscle]
   @State private var muscle: Muscle
   
   @State var instructions = [String?]()
   
   init() {
      // Category
      self.categories = persistenceController.fetchCategory(in: persistenceController.container.viewContext)
      self._category = State(initialValue: categories.first!)
      
      self.equipments = persistenceController.fetchEquipment(in: persistenceController.container.viewContext)
      self._equipment = State(initialValue: equipments.first!)
      
      self.forces = persistenceController.fetchForce(in: persistenceController.container.viewContext)
      self._force = State(initialValue: forces.first!)
      
      self.levels = persistenceController.fetchLevel(in: persistenceController.container.viewContext)
      self._level = State(initialValue: levels.first!)
      
      self.mechanics = persistenceController.fetchMechanic(in: persistenceController.container.viewContext)
      self._mechanic = State(initialValue: mechanics.first!)
      
      self.muscles = persistenceController.fetchMuscle(in: persistenceController.container.viewContext)
      self._muscle = State(initialValue: muscles.first!)
   }
   
    var body: some View {
       NavigationView {
          Form {
             Section {
                TextField("Name", text: $name)
                TextField("Link", text: $link)
                TextField("Note", text: $note)
             }
             
             Section {
                Button {
                   instructions.append("")
                } label: {
                   Text("Add a step")
                }

                ForEach(0 ..< instructions.count, id: \.self) { index in
                   HStack {
                      TextField("Step \(index + 1)", text: getBinding(forIndex: index))
                      Spacer()
                         Button {
                            instructions[index] = ""
                            instructions.remove(at: index)
                         } label: {
                            Image(systemName: "minus.circle")
                               .foregroundColor(.red)
                         }
                         .buttonStyle(.plain)
                   }
                }
             } header: {
                Text("Instructions")
             }

             Section {
                Picker("Category", selection: $category) {
                   ForEach(categories) { object in
                      Text(object.name?.capitalized ?? "-")
                         .tag(object)
                   }
                }
                
                Picker("Equipment", selection: $equipment) {
                   ForEach(equipments) { object in
                      Text(object.name?.capitalized ?? "-")
                         .tag(object)
                   }
                }
                
                Picker("Force", selection: $force) {
                   ForEach(forces) { object in
                      Text(object.name?.capitalized ?? "-")
                         .tag(object)
                   }
                }
                
                Picker("Level", selection: $level) {
                   ForEach(levels) { object in
                      Text(object.name?.capitalized ?? "-")
                         .tag(object)
                   }
                }
                
                Picker("Mechanic", selection: $mechanic) {
                   ForEach(mechanics) { object in
                      Text(object.name?.capitalized ?? "-")
                         .tag(object)
                   }
                }
                
                Picker("Muscle", selection: $muscle) {
                   ForEach(muscles) { object in
                      Text(object.name?.capitalized ?? "-")
                         .tag(object)
                   }
                }
                
             }
          }
          .navigationTitle("New Exercise")
          .toolbar {
             ToolbarItem(placement: .navigationBarTrailing) {
                navigationBarTrailingItem
             }
             ToolbarItem(placement: .navigationBarLeading) {
                navigationBarLeadingItem
             }
          }
       }
    }
   
   private var navigationBarTrailingItem: some View {
      Button(action: {
         
         _ = Exercise.make(in: managedObjectContext, name: name, link: link, note: note, instructions: instructions.compactMap { $0 }, category: category, equipment: equipment, force: force, level: level, mechanic: mechanic, muscle: muscle)
         
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
   
   private var navigationBarLeadingItem: some View {
      Button(action: {
         presentationMode.wrappedValue.dismiss()
      }, label: {
         Text("Dismiss")
      })
   }
   
   func getBinding(forIndex index: Int) -> Binding<String> {
      return Binding<String>(
         get: {
            if index > instructions.count - 1 {
               return ""
            } else {
               return instructions[index]!
            }
      }, set: {
         instructions[index] = $0
      })
   }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
       
       let context = PersistenceController.preview.container.viewContext
       NewExerciseView()
          .environment(\.managedObjectContext, context)
    }
}
