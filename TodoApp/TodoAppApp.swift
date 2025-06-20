//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/16/25.
//

import SwiftUI

@main
struct TodoAppApp: App {
	let persistenceController = PersistenceController.shared
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
				.environmentObject(IconNames())
		}
	}
}


// MARK: - alternate icons

class IconNames: ObservableObject {
	var iconNames: [String?] = [nil]
	@Published var currentIndex = 0
	
	init() {
		getAlternateIconNames()
		
		if let currentIcon = UIApplication.shared.alternateIconName {
			self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
		}
	}
	
	func getAlternateIconNames() {
		if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any], let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
			for (_, value) in alternateIcons {
				guard let iconList = value as? Dictionary<String, Any> else { return }
				guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
				guard let icon = iconFiles.first else { return }
				
				iconNames.append(icon)
			}
		}
	}
}
