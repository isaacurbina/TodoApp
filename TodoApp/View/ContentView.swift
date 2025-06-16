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
	
	@State private var showingAddTodoView: Bool = false
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			List(0..<5) { item in
				Text("Hello, World!")
			} // List
			.navigationBarTitle("Todo", displayMode: .inline)
			.navigationBarItems(
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
	ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
