//
//  AboutView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import SwiftUI

/// Displays a ScrollView with texts for the user's follower count and description.
struct AboutView: View {
	let user: User
	let totalFollowers: Int
	
	var body: some View {
		ScrollView {
			self.followersAndDescriptionSection
		}
	}
	
	/// Displays a VStack with texts for the follower amount and description of the user.
	private var followersAndDescriptionSection: some View {
		VStack(alignment: .leading) {
			Text("\(totalFollowers) followers")
			
			Text(user.description)
		}
	}
}

#Preview {
	AboutView(user:
			.init(
				id: "5455",
				login: "SusBaka121",
				displayName: "SusBaka121",
				description: "Very sus",
				profileImageURL: "https://i.scdn.co/image/ab67616d00001e0237aa83334afa61c17331bde0",
				createdAt: "2020"
			), totalFollowers: 50345)
}
