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
	@EnvironmentObject var iconSettings: IconNames
	
	
	// MARK: - theme
	
	private let themes: [Theme] = themeData
	@ObservedObject private var theme = ThemeSettings.shared
	@State private var isThemeChanged: Bool = false
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			VStack(alignment: .center, spacing: 0) {
				
				
				// MARK: - form
				
				Form {
					
					
					// MARK: - section 1
					
					Section(header: Text("Choose the app icon")) {
						
						Picker(
							selection: $iconSettings.currentIndex,
							label:
								HStack {
									ZStack {
										RoundedRectangle(cornerRadius: 8, style: .continuous)
											.strokeBorder(style: .primary, lineWidth: 2)
										
										Image(systemName: "paintbrush")
											.font(.system(size: 28, weight: .regular, design: .default))
									} // ZStack
									.frame(width: 44, height: 44)
									
									Text("App Icons".uppercased())
										.fontWeight(.bold)
										.foregroundColor(.primary)
								} // HStack
						) {
							
							ForEach(0..<iconSettings.iconNames.count) { index in
								
								HStack {
									
									Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
										.renderingMode(.original)
										.resizable()
										.scaledToFit()
										.frame(width: 44, height: 44)
										.cornerRadius(8)
									
									Spacer()
										.frame(width: 8)
									
									Text(iconSettings.iconNames[index] ?? "Blue")
										.frame(alignment: .leading)
									
								} //HStack
								
							} // ForEach
							
						} // Picker
						.pickerStyle(.inline)
						.onReceive([iconSettings.currentIndex].publisher.first()) {(value) in
							let index = iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
							if index != value {
								UIApplication.shared.setAlternateIconName(iconSettings.iconNames[value]) { error in
									if let error = error {
										print(error.localizedDescription)
									} else {
										print("Success! You have changed the app icon.")
									}
								}
							}
						}
						
					} // Section
					.padding(.vertical, 3)
					
					
					// MARK: - section 2
					
					Section(
						header:
							HStack {
								Text("Choose the app theme")
								Image(systemName: "circle.fill")
									.resizable(width: 10, height: 10)
									.foregroundColor(themes[self.theme.themeSettings].themeColor)
							} // HStack
					) {
						
						List {
							ForEach(themes, id: \.id) { item in
								
								Button(action: {
									self.theme.themeSettings = item.id
									UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
									isThemeChanged.toggle()
								}) {
									HStack {
										Image(systemName: "circle.fill")
											.foregroundColor(item.themeColor)
										Text(item.themeName)
									} // HStack
								} // Button
								.accentColor(.primary)
								
							} // ForEach
						} // List
						
					} // Section
					.padding(.vertical, 3)
					.alert(isPresented: $isThemeChanged) {
						Alert(title: Text("Success"), message: Text("App has been changed to the \(themes[theme.themeSettings].themeName). Now close and restart it!"), dismissButton: .default("OK"))
					}
					
					
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
		.accentColor(themes[self.theme.themeSettings].themeColor)
		.navigationViewStyle(StackNavigationViewStyle())
	}
}


// MARK: - preview

#Preview {
	SettingsView()
		.environmentObject(IconNames())
}
