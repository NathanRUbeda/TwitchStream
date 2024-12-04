//
//  HomeView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import AVKit
import SwiftUI

/// Displays a VStack of video thumbnails and stream categories.
struct HomeView: View {
	@Binding var tabSelection: TabBarItem
	
	let user: User
	let videos: [Video]
	let rows = [
		GridItem(.adaptive(minimum: 330))
	]
	let categories = ["categoryArt", "categoryJustChatting", "categoryRetroGaming"]
	
	var body: some View {
		VStack(alignment: .leading) {
			self.featuredClipsSection
			
			self.streamedCategoriesText
			
			self.recentlyStreamedCategories
		}
	}
	
	/// Displays the Featured Clips section, containing a "Show All" button and a ScrollView of clips.
	private var featuredClipsSection: some View {
		ScrollView(.horizontal) {
			LazyHStack {
				VStack {
					self.featuredClipsText
					
					self.showAllButton
				}
				.background {
					self.backgroundRectangle
				}
				.padding(.trailing, 30)
				
				self.videoMiniaturesForEach
			}
		}
			.scrollIndicators(.hidden)
	}
	
	/// Displays a cyan RoundedRectangle.
	private var backgroundRectangle: some View {
		RoundedRectangle(cornerRadius: 6)
			.frame(width: 150, height: 240)
			.foregroundStyle(.cyan)
	}
	
	/// Displays a "Featured Clips" text.
	private var featuredClipsText: some View {
		Text("Featured Clips")
			.font(.title3)
			.fontWeight(.semibold)
	}
	
	/// Displays a button labeled as a "Show All" text.
	private var showAllButton: some View {
		Button {
			self.tabSelection = .videos
		} label: {
			self.buttonLabel
		}
	}
	
	/// Displays a "Show All" text.
	private var buttonLabel: some View {
		Text("Show All")
			.fontWeight(.semibold)
			.padding(6)
			.background(.white)
			.clipShape(RoundedRectangle(cornerRadius: 6))
	}
	
	/// Displays a ForEach of NavigationLinks labeled as video miniatures.
	private var videoMiniaturesForEach: some View {
		ForEach(videos) { video in
			NavigationLink {
				// mock video
			} label: {
				VideoMiniatureView(video: video)
			}
			.buttonStyle(.plain)
		}
	}
	
	/// Displays a text indicating user's streamed categories.
	private var streamedCategoriesText: some View {
		Text("\(user.displayName)'s recently streamed Categories")
			.font(.largeTitle)
			.fontWeight(.semibold)
	}
	
	/// Displays a HStack with a ForEach containing imaegs for the user's streamed categories.
	private var recentlyStreamedCategories: some View {
		HStack {
			ForEach(categories, id: \.self) { category in
				Image(category)
					.resizable()
					.frame(width: 200, height: 250)
			}
		}
	}
}
