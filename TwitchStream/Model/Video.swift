//
//  Video.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import Foundation

/// An object that represents a video.
struct Video: Codable, Identifiable {
	/// ID of the video.
	let id: String
	
	/// ID of the stream where the video was clipped.
	let streamID: String
	
	/// ID of the user (creator of the video).
	let userID: String
	
	/// Name of the user (creator of the video).
	let userName: String
	
	/// Title of the video.
	let title: String
	
	/// Description of the video.
	let description: String
	
	/// Date when video was created.
	let createdAt: String
	
	/// URL of the video.
	let url: String
	
	/// URL of the video's thumbnail.
	let thumbnailUrl: String
	
	/// Total amount of video's views.
	let viewCount: Int
	
	/// Duration of the video.
	let duration: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case streamID = "stream_id"
		case userID = "user_id"
		case userName = "user_name"
		case title
		case description
		case createdAt = "created_at"
		case url
		case thumbnailUrl = "thumbnail_url"
		case viewCount = "view_count"
		case duration
	}
}

