//
//  Follower.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/25/24.
//

import Foundation

/// An object that represents a follower.
struct Follower: Codable {
	/// ID of the user.
	let userID: String
	
	/// Name of the user.
	let userName: String
	
	enum CodingKeys: String, CodingKey {
		case userID = "user_id"
		case userName = "user_name"
	}
}
