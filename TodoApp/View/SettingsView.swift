//
//  SettingsView.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/18/25.
//

import SwiftUI

struct SettingsView: View {
	
	
	// MARK: - properties
	
	@Environment(\.presentationMode) var presentationMode
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			VStack(alignment: .center, spacing: 0) {
				
				
				// MARK: - form
				
				Form {
					
					
					// MARK: - section 3
					
					Section(header: Text("Follow us on social media")) {
						
						FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://swiftuimasterclass.com")
						FormRowLinkView(icon: "link", color: .blue, text: "Twitter", link: "https://twitter.com/robertpetras")
						FormRowLinkView(icon: "play.rectangle", color: .green, text: "Courses", link: "https://www.udemy.com/user/robert-petras")
						
					} // Section
					.padding(.vertical, 3)
					
					
					// MARK: - section 4
					
					Section(header: Text("About the application")) {
						
						FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
						FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibiltiy", secondText: "iPhone, iPad")
						FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Isaac Urbina")
						FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
						FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
						
					} // Section
					.padding(.vertical, 3)
					
				} // Form
				.listStyle(GroupedListStyle())
				.environment(\.horizontalSizeClass, .regular)
				
				
				// MARK: - footer
				
				Text("Copyright © 2025 All rights reserved.\nBetter Apps ♡ Less Code\nIsaac Urbina")
					.multilineTextAlignment(.center)
					.font(.footnote)
					.padding(.top, 6)
					.padding(.bottom, 8)
					.foregroundColor(.secondary)
				
			} // VStack
			.padding(.top, 90)
			.padding(.bottom, 24)
			.navigationBarItems(
				trailing:
					Button(action: {
						presentationMode.wrappedValue.dismiss()
					}) {
						Image(systemName: "xmark")
					}
			)
			.navigationBarTitle("Settings", displayMode: .inline)
			.background(Color("ColorBackground"))
			.edgesIgnoringSafeArea(.all)
			
		} // NavigationView
	}
}


// MARK: - preview

#Preview {
	SettingsView()
}
