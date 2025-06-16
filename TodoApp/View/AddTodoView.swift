//
//  AddTodoView.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/16/25.
//

import SwiftUI

struct AddTodoView: View {
	
	
	// MARK: - properties
	
	@Environment(\.presentationMode) var presentationMode
	
	@State private var name: String = ""
	@State private var priority: String = "Normal"
	
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
						print("Save a new todo item.")
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
			
		} // NavigationView
	}
}


// MARK: - preview

#Preview {
	AddTodoView()
}
