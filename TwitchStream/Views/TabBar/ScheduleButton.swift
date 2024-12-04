//
//  ScheduleButton.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/3/24.
//

import SwiftUI

/// Displays a button labeled as an icon image.
struct ScheduleButton: View {
	let imageSystemName: String
	let fontWeight: Font.Weight
	let verticalPadding: CGFloat
	let horizontalPadding: CGFloat
	let backgroundColor: Color
	
	var body: some View {
		Button {
			// mock button
		} label: {
			self.buttonLabel
		}
		.buttonStyle(.plain)
	}
	
	/// Displays an icon image.
	private var buttonLabel: some View {
		Image(systemName: imageSystemName)
			.fontWeight(fontWeight)
			.padding(.vertical, verticalPadding)
			.padding(.horizontal, horizontalPadding)
			.background(backgroundColor)
			.clipShape(RoundedRectangle(cornerRadius: 6))
	}
}
