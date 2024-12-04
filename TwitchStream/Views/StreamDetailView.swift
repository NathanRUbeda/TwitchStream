//
//  StreamDetailView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/22/24.
//

import SwiftUI

/// Displays a scrollable LazyVStack containing detailed information about the stream.
struct StreamDetailView: View {
	let twitchStreamProvider = TwitchStreamProvider()
	let stream: Stream
	let user: User
	
	var followerVideoModel = FollowerViewModel()
	var videoViewModel = VideoViewModel()
	
	var resizedThumbnailURL: String {
		return stream.thumbnailURL.replacingOccurrences(of: "{width}", with: "750").replacingOccurrences(of: "{height}", with: "400")
	}
	
    var body: some View {
		LazyVStack(alignment: .leading) {
			ScrollView {
				self.thumbnail
				
				HStack {
					self.userIcon
					
					VStack (alignment: .leading) {
						self.userNameSection
						
						self.titleSection
						
						self.gameNameSection
					}
				}
				
				self.aboutSection
			}
			.onAppear {
				_fetchInitialVideos()
				_fetchFollowers()
			}
		}
    }
	
	/// Displays the stream's thumbnail image.
	private var thumbnail: some View {
		AsyncImage(url: URL(string: resizedThumbnailURL)) { phase in
			if let image = phase.image {
				image
					.resizable()
					.scaledToFit()
					.frame(width: 1400, height: 800)
			} else if phase.error != nil {
				self.errorView
			} else {
				self.progressView
			}
		}
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
	
	/// Displays a ProgressView.
	private var progressView: some View {
		ProgressView()
			.frame(width: 1400, height: 800)
			.background(Color.gray.opacity(0.35))
	}
	
	/// Displays a NavigationLink labeled with the user's icon.
	private var userIcon: some View {
		NavigationLink {
			UserDetailView(
				user: user,
				videos: videoViewModel
					.videos, totalFollowers: followerVideoModel.totalFollowers)
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
					self.defaultUserIcon
				} else {
					ProgressView()
				}
			}
		}
		.buttonStyle(.plain)
	}
	
	/// Displays a default user image.
	private var defaultUserIcon: some View {
		Image("defaultUserIcon")
			.resizable()
			.frame(width: 40, height: 40)
			.clipShape(Circle())
	}
	
	/// Displays an HStack containing the name of the user and channel-interactive buttons.
	private var userNameSection: some View {
		HStack {
			self.userNameNavigationLink
			
			Spacer()
			
			MenuButton(
				imageSystemName: "heart",
				text: "Follow",
				textColor: Color.white,
				backgroundColor: Color.purple,
				hasChevron: false
			)
			
			MenuButton(
				imageSystemName: "gift",
				text: "Gift a sub",
				textColor: Color.black,
				backgroundColor: Color.secondary.opacity(0.35),
				hasChevron: true
			)
			
			MenuButton(
				imageSystemName: "star",
				text: "Subscribe",
				textColor: Color.black,
				backgroundColor: Color.secondary.opacity(0.35),
				hasChevron: true
			)
			
			Spacer()
		}
	}
	
	/// Displays a NavigationLink labeled as a text with the name of the user.
	private var userNameNavigationLink: some View {
		NavigationLink {
			UserDetailView(
				user: user,
				videos: videoViewModel
					.videos, totalFollowers: followerVideoModel.totalFollowers)
		} label: {
			self.userNameText
		}
		.buttonStyle(.plain)
	}
	
	/// Displays a text with name of the user.
	private var userNameText: some View {
		Text(stream.userName)
			.font(.title2)
			.fontWeight(.bold)
			.padding(.bottom, 3)
	}
	
	/// Displays an HStack containing the title of the tream, and the viewer count.
	private var titleSection: some View {
		HStack {
			Text(stream.title)
			
			Group {
				Image(systemName: "person")
					.font(.title2)
				
				Text(String(stream.viewerCount))
			}
			.fontWeight(.semibold)
			.foregroundStyle(.red)
		}
	}
	
	/// Displays an HStack containing a text for the streamed game's name and a ForEach with the stream tags.
	private var gameNameSection: some View {
		HStack {
			Text(stream.gameName)
				.foregroundStyle(.purple)
			
			self.tagsLoop
		}
	}
	
	/// Displays a ForEach containing the stream tags.
	private var tagsLoop: some View {
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
	
	/// Displays a VStack with general information about the user, such as name, followers and social media accounts.
	private var aboutSection: some View {
		VStack(alignment: .leading) {
			self.userDisplayName
			
			Group {
				HStack {
					self.totalFollowersAndDescriptionStack
					
					Spacer()
					
					self.socialMediaButtonsStack
				}
				.padding(.horizontal, 16)
			}
			.frame(width: 1200)
			.background(.white)
			.clipShape(RoundedRectangle(cornerRadius: 3))
		}
	}
	
	/// Displays a VStack with texts for the total followers amount and the user's description.
	private var totalFollowersAndDescriptionStack: some View {
		VStack(alignment: .leading) {
			Text("\(followerVideoModel.totalFollowers) followers")
				.padding(.bottom, 16)
			
			Text(user.description)
		}
	}
	
	/// Displays a text with the display name of the user/
	private var userDisplayName: some View {
		Text("About \(user.displayName)")
			.font(.title2)
			.fontWeight(.bold)
	}
	
	/// Displays a VStack of SocialMediaButton.
	private var socialMediaButtonsStack: some View {
		VStack {
			SocialMediaButton(imageString: "logoYoutube", width: 45, height: 30)
			
			SocialMediaButton(imageString: "logoInstagram", width: 27, height: 27)
			
			SocialMediaButton(imageString: "logoX", width: 25, height: 25)
		}
	}
	
	/// Fetches followers.
	private func _fetchFollowers() {
		Task {
			do {
				defer {
					self.videoViewModel.isFetching = false
				}
				self.videoViewModel.isFetching = true
				
				let response = try await self.twitchStreamProvider.fetchFollowers(
					broadcasterID: self.user.id)
				self.followerVideoModel.totalFollowers = response.total
				
			} catch {
				print(error)
			}
		}
	}
	
	/// Fetches initial videos.
	private func _fetchInitialVideos() {
		Task {
			do {
				let videos = try await self._fetchVideos(userID: self.user.id)
				self.videoViewModel.videos = videos
			} catch {
				print(error)
			}
		}
	}
	
	/// Fetches videos based on the ID of the user.
	/// - Parameters:
	/// - userID: The ID of the user.
	/// - Returns: An array of `Video` objects.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	private func _fetchVideos(userID: String) async throws -> [Video] {
		defer {
			self.videoViewModel.isFetching = false
		}
		self.videoViewModel.isFetching = true
		let response = try await self.twitchStreamProvider.fetchVideos(userID: userID)
		
		return response.data
	}
}

#Preview {
	StreamDetailView(stream: .init(
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
	), user:
			.init(
				id: "5455",
				login: "SusBaka121",
				displayName: "SusBaka121",
				description: "Very sus",
				profileImageURL: "https://i.scdn.co/image/ab67616d00001e0237aa83334afa61c17331bde0",
				createdAt: "2020"
			)
	)
}
