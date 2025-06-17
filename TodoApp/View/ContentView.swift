//
//  ContentView.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/16/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
	
	
	// MARK: - properties
	
	@Environment(\.managedObjectContext) var managedObjectContext
	
	@FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
	
	@State private var showingAddTodoView: Bool = false
	
	
	// MARK: - functions
	
	private func deleteTodo(at offsets: IndexSet) {
		for index in offsets {
			let todo = todos[index]
			managedObjectContext.delete(todo)
			do {
				try managedObjectContext.save()
			} catch {
				print(error)
			}
		}
	}
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			List {
				ForEach(todos, id: \.self){ todo in
					HStack {
						Text(todo.name ?? "Unknown")
						Spacer()
						Text(todo.priority ?? "Unknown")
					} // HStack
				} // ForEach
				.onDelete(perform: deleteTodo)
			} // List
			.navigationBarTitle("Todo", displayMode: .inline)
			.navigationBarItems(
				leading: EditButton(),
				trailing:
					Button(action: {
						showingAddTodoView.toggle()
					}) {
						Image(systemName: "plus")
					} // Button
					.sheet(isPresented: $showingAddTodoView) {
						AddTodoView()
							.environment(\.managedObjectContext, managedObjectContext)
					}
			)
		} // NavigationView
	}
}


// MARK: - preview

#Preview {
	let context = PersistenceController.preview.container.viewContext
	ContentView()
		.environment(\.managedObjectContext, context)
}
