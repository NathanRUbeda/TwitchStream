//
//  SocialMediaButton.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import SwiftUI

/// Displays a button labeled as a social media icon image.
struct SocialMediaButton: View {
	let imageString: String
	let width: CGFloat
	let height: CGFloat
	
	var body: some View {
		Button {
			// mock button
		} label: {
			self.buttonLabel
		}
		.buttonStyle(.plain)
	}
	
	/// Displays an social media icon image.
	private var buttonLabel: some View {
		Image(imageString)
			.resizable()
			.frame(width: width, height: height)
			.scaledToFit()
	}
}
