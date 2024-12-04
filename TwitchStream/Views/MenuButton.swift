//
//  MenuButton.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import SwiftUI

/// Displays a menu button labeled as an icon image and a text.
struct MenuButton: View {
	let imageSystemName: String
	let text: String
	let textColor: Color
	let backgroundColor: Color
	let hasChevron: Bool
	
	var body: some View {
		Button {
			// mock Button
		} label: {
			self.buttonLabel
		}
		.buttonStyle(.plain)
	}
	
	/// Displays an HStack with a icon image, a text, and an optional image.
	private var buttonLabel: some View {
		HStack {
			Image(systemName: imageSystemName)
				.fontWeight(.semibold)
				.foregroundStyle(textColor)
			
			Text(text)
				.fontWeight(.semibold)
				.foregroundStyle(textColor)
			
			if hasChevron {
				Image(systemName: "chevron.down")
					.fontWeight(.semibold)
					.foregroundStyle(textColor)
			}
		}
		.padding(6)
		.background(
			RoundedRectangle(cornerRadius: 4)
				.fill(backgroundColor)
		)
	}
}
