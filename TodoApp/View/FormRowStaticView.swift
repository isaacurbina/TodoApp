//
//  FormRowStaticView.swift
//  TodoApp
//
//  Created by Isaac Urbina on 6/18/25.
//

import SwiftUI

struct FormRowStaticView: View {
	
	
	// MARK: - properties
	
	var icon: String
	var firstText: String
	var secondText: String
	
	
	// MARK: - body
	
	var body: some View {
		HStack {
			ZStack {
				RoundedRectangle(cornerRadius: 8, style: .continuous)
					.fill(.gray)
				Image(systemName: icon)
					.foregroundColor(.white)
			} // ZStack
			.frame(width: 36, height: 36, alignment: .center)
			
			Text(firstText)
				.foregroundColor(.gray)
			
			Spacer()
			
			Text(secondText)
		} // HStack
	}
}


// MARK: - preview

#Preview {
	FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
		.previewLayout(.fixed(width: 375, height: 60))
		.padding()
}
