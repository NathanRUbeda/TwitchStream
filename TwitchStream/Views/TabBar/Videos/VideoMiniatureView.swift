//
//  VideoMiniatureView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/24/24.
//

import SwiftUI

/// Displays a VStack containing the thumbnail, title, and name of the creators of the video.
struct VideoMiniatureView: View {
	let video: Video
	
	var resizedThumbnailURL: String {
		return video.thumbnailUrl
			.replacingOccurrences(of: "%{width}", with: "320")
			.replacingOccurrences(of: "%{height}", with: "180")
	}
	
	var duration: Date {
		let duration = _isoStringToDate(string: video.duration)
		return duration
	}
	
	var createdAtDate: String {
		let date = _rfcStringToDate(string: video.createdAt)
		let timeAgo = date.timeAgoDisplay()
		return timeAgo
	}
	
    var body: some View {
		VStack(alignment: .leading) {
			self.videoThumbnailImage
				
			self.videoTitleText
			
			self.userNameText
			
			self.clippedBySomeoneText
		}
		.frame(width: 320)
    }
	
	/// Displays an AsyncImage of the video's thumbnail.
	private var videoThumbnailImage: some View {
		AsyncImage(url: URL(string: resizedThumbnailURL)) { phase in
			if let image = phase.image {
				image
					.resizable()
					.frame(width: 320, height: 180)
					.overlay(alignment: .bottomLeading) {
						self.viewCountText
					}
					.overlay(alignment: .topLeading) {
						self.durationText
					}
					.overlay(alignment: .bottomTrailing) {
						self.createdAtDateText
					}
			} else if phase.error != nil {
				self.errorView
			} else {
				ProgressView()
			}
		}
	}
	
	/// Displays a text with the view count of the video.
	private var viewCountText: some View {
		Text("\(video.viewCount.asFormattedString) views")
			.foregroundStyle(.white)
			.padding(2)
			.background(.black.opacity(0.4))
			.clipShape(RoundedRectangle(cornerRadius: 2))
			.padding(8)
	}
	
	/// Displays a text with the duration of the video.
	private var durationText: some View {
		Text(duration, style: .time)
			.foregroundStyle(.white)
			.padding(2)
			.background(.black.opacity(0.4))
			.clipShape(RoundedRectangle(cornerRadius: 2))
			.padding(8)
	}
	
	/// Displays a text with the video's creation date.
	private var createdAtDateText: some View {
		Text("\(createdAtDate)")
			.foregroundStyle(.white)
			.padding(2)
			.background(.black.opacity(0.4))
			.clipShape(RoundedRectangle(cornerRadius: 2))
			.padding(8)
	}
	
	/// Displays a gray Rectangle with an exclamation mark image and a text.
	private var errorView: some View {
		Rectangle()
			.frame(width: 320, height: 180)
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
	
	/// Displays a text with the title of the video.
	private var videoTitleText: some View {
		Text(video.title)
			.fontWeight(.semibold)
			.lineLimit(1)
	}
	
	/// Displays a text with the video creator's user name.
	private var userNameText: some View {
		Text(video.userName)
	}
	
	/// Displays a "Clipped by Someone" text.
	private var clippedBySomeoneText: some View {
		Text("Clipped by Someone")
	}
	
	/// Formats an ISO string into a Date value.
	/// - Parameters:
	/// - string: A string containing a date in an ISO format.
	/// - Returns: A `Date` object.
	private func _isoStringToDate(string: String) -> Date {
		let formatter = ISO8601DateFormatter()
		let date = formatter.date(from: string)
		return date ?? Date.now
	}
	
	/// Formats a RFC string into a Date value.
	/// - Parameters:
	/// - string: A string containing a date in an RFC format.
	/// - Returns: A `Date` object.
	private func _rfcStringToDate(string: String) -> Date {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "en_US_POSIX")
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		let date = formatter.date(from: string)
		
		return date ?? Date.now
	}
}

#Preview {
	VideoMiniatureView(video:
			.init(id: "555", streamID: "6444", userID: "5455", userName: "SusBaka121", title: "AMOGUS Gameplay", description: "Game game game", createdAt: "2 months ago", url: "https://www.youtube.com/watch?v=Mj6tdAjFWOo", thumbnailUrl: "https://i.ytimg.com/vi/Mj6tdAjFWOo/maxresdefault.jpg", viewCount: 50000, duration: "25:31")
	)
}
