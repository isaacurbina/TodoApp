//
//  ThemeSettings.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/25/25.
//

import SwiftUI

final class ThemeSettings: ObservableObject {
	
	@Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
		didSet {
			UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
		}
	}
	
	private init() {}
	public static let shared = ThemeSettings()
}
