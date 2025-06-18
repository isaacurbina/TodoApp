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
	@State private var animatingButton: Bool = false
	
	
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
			ZStack {
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
				
				if todos.count == 0 {
					EmptyListView()
				}
				
			} // ZStack
			.sheet(isPresented: $showingAddTodoView) {
				AddTodoView()
					.environment(\.managedObjectContext, managedObjectContext)
			}
			.overlay(
				ZStack {
					Group {
						Circle()
							.fill(.blue)
							.opacity(animatingButton ? 0.2 : 0)
							.scaleEffect(animatingButton ? 1 : 0)
							.frame(width: 68, height: 68, alignment: .center)
						
						Circle()
							.fill(.blue)
							.opacity(animatingButton ? 0.15 : 0)
							.scaleEffect(animatingButton ? 1 : 0)
							.frame(width: 88, height: 88, alignment: .center)
					} // Group
					.animation(.easeInOut(duration: 2).repeatForever(autoreverses: true))
					
					Button(action: {
						showingAddTodoView.toggle()
					}) {
						Image(systemName: "plus.circle.fill")
							.resizable()
							.scaledToFit()
							.background(Circle().fill(Color("ColorBase")))
							.frame(width: 48, height: 48, alignment: .center)
					} // Button
					.onAppear {
						animatingButton.toggle()
					}
					
				} // ZStack
					.padding(.bottom, 15)
					.padding(.trailing, 20)
				, alignment: .bottomTrailing
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
