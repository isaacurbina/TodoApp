//
//  FormRowLinkView.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/18/25.
//

import SwiftUI

struct FormRowLinkView: View {
	
	
	// MARK: - properties
	
	var icon: String
	var color: Color
	var text: String
	var link: String
	
	
	// MARK: - body
	
	var body: some View {
		HStack {
			
			ZStack {
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.fill(color)
				Image(systemName: icon)
					.imageScale(.large)
					.foregroundColor(.white)
			} // ZStack
			.frame(width: 36, height: 36, alignment: .center)
			
			Text(text)
				.foregroundColor(.gray)
			
			Spacer()
			
			Button(action: {
				guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else {
					return
				}
				UIApplication.shared.openURL(url as URL)
			}) {
				Image(systemName: "chevron.right")
					.font(.system(size: 14, weight: .semibold, design: .rounded))
					.accentColor(Color(.systemGray2))
			}
			
		} // HStack
	}
}


// MARK: - preview

#Preview {
	FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://swiftuimasterclass.com")
		.previewLayout(.fixed(width: 375, height: 60))
		.padding()
}
