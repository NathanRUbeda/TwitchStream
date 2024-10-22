//
//  Stream.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import Foundation

struct StreamResponse: Codable {
	let data: [Stream]
}

struct Stream: Codable, Identifiable {
	let id: String
	let userID: String
	let userName: String
	let gameName: String
	let type: String
	let title: String
	let tags: [String]
	let viewerCount: Int
	let language: String
	let thumbnailURL: String
	
	enum CodingKeys: String, CodingKey {
		case userID = "user_id"
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
