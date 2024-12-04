//
//  ContentView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import SwiftUI

/// Displays a NavigationStack with a scrollable LazyVGrid containing popular streams.
struct ContentView: View {
	let streams: [Stream]
	let users: [User]
	let columns = [
		GridItem(.adaptive(minimum: 320)),
	]
	
	var body: some View {
		NavigationStack {
			ScrollView {
				LazyVGrid(columns: columns) {
					self.streamMiniatureForEach
					.safeAreaPadding()
				}
				.toolbarBackground(.white)
				.toolbar {
					ToolbarItem(placement: .navigation) {
						self.twitchLogoImage
					}
					
					ToolbarItem(placement: .primaryAction) {
						self.userButton
					}
				}
			}
		}
	}
	
	/// Displays a ForEach of stream miniatures.
	private var streamMiniatureForEach: some View {
		ForEach(self.streams) { stream in
			ForEach(self.users) { user in
				if user.login == stream.userLogin {
					StreamMiniatureView(
						stream: stream,
						user: user
					)
					.frame(maxWidth: 300)
				}
			}
		}
	}
	
	/// Displays an image of the Twitch's logo.
	private var twitchLogoImage: some View {
		Image("twitchLogo")
			.resizable()
			.frame(width: 30, height: 30)
	}
	
	/// Displays a button labeled as a user icon image.
	private var userButton: some View {
		Button {
			// mock user button
		} label: {
			self.userIconImage
		}
	}
	
	/// Displays an image of the user icon.
	private var userIconImage: some View {
		Image(systemName: "person.circle.fill")
			.resizable()
			.frame(width: 30, height: 30)
			.foregroundStyle(.blue)
	}
}
