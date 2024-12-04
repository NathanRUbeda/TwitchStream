//
//  VideosView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import AVKit
import SwiftUI

/// Displays a scrollable LazyVGrid containing NavigationLinks labeled as video miniatures.
struct VideosView: View {
	let videos: [Video]
	let columns = [
		GridItem(.adaptive(minimum: 320))
	]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns) {
				self.videoMiniaturesForEach
			}
		}
	}
	
	/// Displays a ForEach of NavigationLinks labeled as video miniatures.
	private var videoMiniaturesForEach: some View {
		ForEach(videos) { video in
			NavigationLink {
				VStack {
					// mock video
				}
			} label: {
				VideoMiniatureView(video: video)
			}
			.buttonStyle(.plain)
		}
	}
}

#Preview {
	VideosView(
		videos: [.init(id: "555", streamID: "6444", userID: "5455", userName: "SusBaka121", title: "AMOGUS Gameplay", description: "Game game game", createdAt: "2020", url: "https://www.youtube.com/watch?v=Mj6tdAjFWOo", thumbnailUrl: "https://i.ytimg.com/vi/Mj6tdAjFWOo/maxresdefault.jpg", viewCount: 50000, duration: "25:31")]
	)
}
