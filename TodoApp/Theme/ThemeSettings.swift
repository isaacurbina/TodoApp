//
//  ThemeSettings.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/25/25.
//

import SwiftUI

class ThemeSettings: ObservableObject {
	
	@Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
		didSet {
			UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
		}
	}
}
