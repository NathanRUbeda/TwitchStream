//
//  UserDetailView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import SwiftUI

/// Displays a ScrollView with a TabBar containing information about the user's channel.
struct UserDetailView: View {
	let user: User
	let videos: [Video]
	let totalFollowers: Int
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				HStack {
					self.userProfileImage
					self.displayNameAndFollowersTexts
				}
				
				self.tabBar
			}
		}
    }
	
	/// Displays an AsyncImage of the user's profile picture.
	private var userProfileImage: some View {
		AsyncImage(
			url: URL(string: user.profileImageURL)
		) { phase in
			if let image = phase.image {
				image
					.resizable()
					.frame(width: 50, height: 50)
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
	
	/// Displays a VStack with texts for the user's display name and amount of followers.
	private var displayNameAndFollowersTexts: some View {
		VStack {
			Text(user.displayName)
				.font(.title2)
				.fontWeight(.bold)
				.padding(.bottom, 3)
			
			Text("\(totalFollowers) followers")
		}
	}
	
	/// Displays an AppTabBarView.
	private var tabBar: some View {
		AppTabBarView(
			user: user,
			videos: videos,
			totalFollowers: totalFollowers
		)
	}
}

#Preview {
	UserDetailView(user: .init(
		id: "5455",
		login: "SusBaka121",
		displayName: "SusBaka121",
		description: "Very sus",
		profileImageURL: "https://i.scdn.co/image/ab67616d00001e0237aa83334afa61c17331bde0",
		createdAt: "2020"
	), videos: [
		.init(id: "555", streamID: "6444", userID: "5455", userName: "SusBaka121", title: "AMOGUS Gameplay", description: "Game game game", createdAt: "2020", url: "https://www.youtube.com/watch?v=Mj6tdAjFWOo", thumbnailUrl: "https://i.ytimg.com/vi/Mj6tdAjFWOo/maxresdefault.jpg", viewCount: 50000, duration: "25:31")
	], totalFollowers: 50543)
}
