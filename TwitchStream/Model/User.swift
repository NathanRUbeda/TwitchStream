//
//  User.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/22/24.
//

import Foundation

/// An object that represents an user.
struct User: Codable, Hashable, Identifiable {
	/// ID of the user.
	let id: String
	
	/// Login of the user.
	let login: String
	
	/// Display name of the user.
	let displayName: String
	
	/// Description of the user.
	let description: String
	
	/// URL of the user's profile image.
	let profileImageURL: String
	
	/// Date when the user created their account.
	let createdAt: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case login
		case displayName = "display_name"
		case description
		case profileImageURL = "profile_image_url"
		case createdAt = "created_at"
	}
}
