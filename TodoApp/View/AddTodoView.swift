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
	
	
	// MARK: - theme
	
	@ObservedObject var theme = ThemeSettings()
	private var themes: [Theme] = themeData
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			VStack {
				VStack(alignment: .leading, spacing: 20) {
					
					
					// MARK: - todo name
					
					TextField("Todo", text: $name)
						.padding()
						.background(Color(UIColor.tertiarySystemFill))
						.cornerRadius(9)
						.font(.system(size: 24, weight: .bold, design: .default))
					
					
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
							.font(.system(size: 24, weight: .bold, design: .default))
							.padding()
							.frame(minWidth: 0, maxWidth: .infinity)
							.background(themes[self.theme.themeSettings].themeColor)
							.cornerRadius(9)
							.foregroundColor(.white)
					} // Button
					
					
				} // VStack
				.padding(.horizontal)
				.padding(.vertical, 30)
				
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
		.accentColor(themes[self.theme.themeSettings].themeColor)
	}
}


// MARK: - preview

#Preview {
	AddTodoView()
}
