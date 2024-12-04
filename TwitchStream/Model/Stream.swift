//
//  Stream.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import Foundation

/// An object that represents a stream.
struct Stream: Codable, Identifiable {
	/// ID of the stream.
	let id: String
	
	/// ID of the user (streamer).
	let userID: String
	
	/// Login of the user (streamer).
	let userLogin: String
	
	/// Name of the user (streamer).
	let userName: String
	
	/// Name of the streamed game.
	let gameName: String
	
	/// Type of the stream.
	let type: String
	
	/// Title of the stream.
	let title: String
	
	/// Tags of the stream.
	let tags: [String]
	
	/// Total amount of viewers watching the stream.
	let viewerCount: Int
	
	/// Language of the stream.
	let language: String
	
	/// URL of the stream's thumbnail.
	let thumbnailURL: String
	
	enum CodingKeys: String, CodingKey {
		case userID = "user_id"
		case userLogin = "user_login"
		case userName = "user_name"
		case gameName = "game_name"
		case viewerCount = "viewer_count"
		case thumbnailURL = "thumbnail_url"
		case id
		case type
		case title
		case tags
		case language
		
	}
}


