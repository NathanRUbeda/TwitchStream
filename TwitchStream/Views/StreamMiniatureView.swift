//
//  StreamMiniatureView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/17/24.
//

import SwiftUI

/// Displays a VStack with the stream's thumbnail and basic information.
struct StreamMiniatureView: View {
	@State private var showPopover = false
	@State private var overTitleText = false
	@State private var overGameText = false
	
	let stream: Stream
	let user: User
	
	var resizedThumbnailURL: String {
		return stream.thumbnailURL.replacingOccurrences(of: "{width}", with: "350").replacingOccurrences(of: "{height}", with: "200")
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			self.thumbnail
			
			HStack(alignment: .top) {
				self.userIcon
		
				VStack(alignment: .leading) {
					self.userTitle
					
					self.userName
					
					self.gameName
					
					self.tags
				}
				.frame(maxWidth: .infinity)
				
				Spacer()
				
				self.optionsButton
			}
		}
		.frame(maxWidth: .infinity)
	}
	
	/// Displays a NavigationLink labeled with the stream's thumbnail.
	private var thumbnail: some View {
		NavigationLink {
			StreamDetailView(stream: stream, user: user)
		} label: {
			AsyncImage(url: URL(string: resizedThumbnailURL)) { phase in
				if let image = phase.image {
					image
						.resizable()
						.scaledToFit()
						.frame(width: 350, height: 200)
						.overlay(alignment: .topLeading) {
							self.liveRectangle
						}
						.overlay(alignment: .bottomLeading) {
							self.viewerCountRectangle
						}
				} else if phase.error != nil {
					self.errorView
				} else {
					ProgressView()
				}
			}
		}
		.buttonStyle(.plain)
	}
	
	/// Displays a text with a red rectangle as a background
	private var liveRectangle: some View {
		Text("LIVE")
			.foregroundStyle(.white)
			.font(.headline)
			.fontWeight(.bold)
			.padding(.horizontal, 6)
			.padding(.vertical, 2)
			.background(
				RoundedRectangle(cornerRadius: 5)
					.fill(.red)
			)
			.padding(8)
	}
	
	/// Displays a text with a semi transparent rectangle as a background.
	private var viewerCountRectangle: some View {
		Text("\(stream.viewerCount.asFormattedString) viewers")
			.foregroundStyle(.white)
			.font(.body)
			.fontWeight(.semibold)
			.padding(3)
			.background(
				RoundedRectangle(cornerRadius: 5)
					.opacity(0.5)
			)
			.padding(8)
	}
	
	/// Displays a gray rectangle with a text and a exclamation mark image.
	private var errorView: some View {
		Rectangle()
			.frame(width: 350, height: 200)
			.foregroundStyle(.gray)
			.overlay(
				VStack {
					Image(systemName: "exclamationmark.octagon")
						.font(.title)
						.foregroundStyle(.red)
					
					Text("Error loading image")
						.fontWeight(.regular)
						.foregroundStyle(.red)
				}
			)
	}
	
	/// Displays a NavigationLink labeled with the user's icon.
	private var userIcon: some View {
		NavigationLink {
			StreamDetailView(stream: stream, user: user)
		} label: {
			AsyncImage(
				url: URL(string: user.profileImageURL)
			) { phase in
				if let image = phase.image {
					image
						.resizable()
						.frame(width: 40, height: 40)
						.clipShape(Circle())
				} else if phase.error != nil {
					Image("defaultUserIcon")
						.resizable()
						.frame(width: 40, height: 40)
						.clipShape(Circle())
				} else {
					ProgressView()
				}
			}
		}
		.buttonStyle(.plain)
	}
	
	/// Displays a NavigationLink labeled with the title of the stream.
	private var userTitle: some View {
		NavigationLink {
			StreamDetailView(stream: stream, user: user)
		} label: {
			Text(stream.title)
				.foregroundStyle(overTitleText ? .purple : .black)
				.fontWeight(.bold)
				.textCase(.uppercase)
				.lineLimit(1)
				.onHover { over in
					overTitleText = over
				}
		}
		.buttonStyle(.plain)
	}
	
	/// Displays a NavigationLink labeled with the name of the user.
	private var userName: some View {
		NavigationLink {
			StreamDetailView(stream: stream, user: user)
		} label: {
			Text(stream.userName)
				.font(.body)
		}
		.buttonStyle(.plain)
	}
	
	/// Displays a text with the name of the streamed game.
	private var gameName: some View {
		Text(stream.gameName)
			.foregroundStyle(overGameText ? .purple : .black)
			.font(.body)
			.onHover { over in
				overGameText = over
			}
	}
	
	/// Displays a loop inside of a HStack containing the stream's tag texts.
	private var tags: some View {
		HStack {
			ForEach(stream.tags, id: \.self) { tag in
				Text(tag)
					.font(.callout)
					.fontWeight(.semibold)
					.padding(.horizontal, 12)
					.padding(.vertical, 4)
					.layoutPriority(1)
					.lineLimit(1)
					.background(
						Capsule()
							.fill(.secondary.opacity(0.35))
					)
			}
		}
		.frame(
			minWidth: 200,
			maxWidth: .infinity,
			alignment: .leading
		)
		.layoutPriority(1)
	}
	
	/// Displays a mock Options button.
	private var optionsButton: some View {
		Button {
			// "options" mock button
		} label: {
			Image(systemName: "ellipsis")
				.rotationEffect(.degrees(90))
		}
		.buttonStyle(.plain)
	}
}

#Preview {
	StreamMiniatureView(
		stream: .init(
			id: "555",
			userID: "5445",
			userLogin: "SusBaka121",
			userName: "SusBaka121",
			gameName: "Among Us",
			type: "live",
			title: "Playing AMOGUS - Who's The Impostor???",
			tags: ["English", "Gaming"],
			viewerCount: 100,
			language: "English",
			thumbnailURL: "https://wallpapers.com/images/featured/among-us-cb21ldue3llceiua.jpg"
		),
		user: .init(
			id: "5455",
			login: "SusBaka121",
			displayName: "SusBaka121",
			description: "Very sus",
			profileImageURL: "https://i.scdn.co/image/ab67616d00001e0237aa83334afa61c17331bde0",
			createdAt: "2020"
		)
	)
}
