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
	@EnvironmentObject var iconSettings: IconNames
	
	@FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
	
	@State private var showingAddTodoView: Bool = false
	@State private var animatingButton: Bool = false
	@State private var showingSettingsView: Bool = false
	
	
	// MARK: - theme
	
	@ObservedObject var theme = ThemeSettings()
	private var themes: [Theme] = themeData
	
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
	
	private func colorize(priority: String) -> Color {
		switch priority {
		case "High":
			return .pink
		case "Normal":
			return .green
		case "Low":
			return .blue
		default: return .gray
		}
	}
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			ZStack {
				List {
					ForEach(todos, id: \.self){ todo in
						
						HStack {
							
							Circle()
								.frame(width: 12, height: 12, alignment: .center)
								.foregroundColor(colorize(priority: todo.priority ?? "Normal"))
							
							Text(todo.name ?? "Unknown")
								.fontWeight(.semibold)
							
							Spacer()
							
							Text(todo.priority ?? "Unknown")
								.font(.footnote)
								.foregroundColor(Color(UIColor.systemGray2))
								.padding(3)
								.frame(minWidth: 62)
								.overlay(
									Capsule()
										.stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
								)
							
						} // HStack
						.padding(.vertical, 10)
						
					} // ForEach
					.onDelete(perform: deleteTodo)
					
				} // List
				.navigationBarTitle("Todo", displayMode: .inline)
				.navigationBarItems(
					leading: EditButton()
						.accentColor(themes[self.theme.themeSettings].themeColor),
					trailing:
						Button(action: {
							showingSettingsView.toggle()
						}) {
							Image(systemName: "paintbrush")
								.imageScale(.large)
						} // Button
						.accentColor(themes[self.theme.themeSettings].themeColor)
						.sheet(isPresented: $showingSettingsView) {
							SettingsView()
								.environment(\.managedObjectContext, managedObjectContext)
								.environmentObject(iconSettings)
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
							.fill(themes[self.theme.themeSettings].themeColor)
							.opacity(animatingButton ? 0.2 : 0)
							.scaleEffect(animatingButton ? 1 : 0)
							.frame(width: 68, height: 68, alignment: .center)
						
						Circle()
							.fill(themes[self.theme.themeSettings].themeColor)
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
					.accentColor(themes[self.theme.themeSettings].themeColor)
					.onAppear {
						animatingButton.toggle()
					}
					
				} // ZStack
					.padding(.bottom, 15)
					.padding(.trailing, 20)
				, alignment: .bottomTrailing
			)
			
		} // NavigationView
		.navigationViewStyle(StackNavigationViewStyle())
	}
}


// MARK: - preview

#Preview {
	let context = PersistenceController.preview.container.viewContext
	ContentView()
		.environment(\.managedObjectContext, context)
}
