//
//  AddTodoView.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/16/25.
//

import SwiftUI
import CoreData

struct AddTodoView: View {
	
	
	// MARK: - properties
	
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.managedObjectContext) var managedObjectContext
	
	@State private var name: String = ""
	@State private var priority: String = "Normal"
	@State private var errorShowing: Bool = false
	@State private var errorTitle: String = ""
	@State private var errorMessage: String = ""
	
	private let priorities = ["High", "Normal", "Low"]
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			
			VStack {
				Form {
					
					
					// MARK: - todo name
					
					TextField("Todo", text: $name)
					
					
					// MARK: - todo priority
					
					Picker("Priority", selection: $priority) {
						ForEach(priorities, id: \.self) { item in
							Text(item)
						} // ForEach
					} // Picker
					.pickerStyle(SegmentedPickerStyle())
					
					
					// MARK: - save button
					
					Button(action: {
						if name != "" {
							let todo = Todo(context: managedObjectContext)
							todo.name = name
							todo.priority = priority
							
							do {
								try managedObjectContext.save()
								print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
							} catch {
								print(error)
							}
							name = ""
							
						} else {
							errorShowing = true
							errorTitle = "Invalid name"
							errorMessage = "Make sure to enter something for the new todo item."
							return
						}
						
						presentationMode.wrappedValue.dismiss()
						
					}) {
						Text("Save")
					} // Button
					
					
				} // Form
				
				Spacer()
				
			} // VStack
			.navigationBarTitle("New Todo", displayMode: .inline)
			.navigationBarItems(
				trailing: Button(action: {
					presentationMode.wrappedValue.dismiss()
				}) {
					Image(systemName: "xmark")
				} // Button
			)
			.alert(isPresented: $errorShowing) {
				Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
			}
			
		} // NavigationView
	}
}


// MARK: - preview

#Preview {
	AddTodoView()
}
