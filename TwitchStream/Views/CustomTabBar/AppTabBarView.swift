//
//  AppTabBarView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import SwiftUI

/// Displays a custom TabBar view.
struct AppTabBarView: View {
	@State private var tabSelection: TabBarItem = .home
	let user: User
	let videos: [Video]
	let totalFollowers: Int
	
    var body: some View {
		CustomTabBarContainerView(selection: $tabSelection) {
			HomeView(tabSelection: $tabSelection, user: user, videos: videos)
				.tabBarItem(
					tab: .home,
					selection: $tabSelection
				)
			
			AboutView(user: user, totalFollowers: totalFollowers)
				.tabBarItem(
					tab: .about,
					selection: $tabSelection
				)
			
			ScheduleView(user: user)
				.tabBarItem(
					tab: .schedule,
					selection: $tabSelection
				)
			
			VideosView(videos: videos)
				.tabBarItem(
					tab: .videos,
					selection: $tabSelection
				)
			
			ChatView()
				.tabBarItem(
					tab: .chat,
					selection: $tabSelection
				)
		}
    }
}

#Preview {
	AppTabBarView(user:
			.init(
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
