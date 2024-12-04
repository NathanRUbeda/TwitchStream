//
//  UserResponse.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that represents a network response containing an array of users.
struct UserResponse: Codable {
	/// Array of users retrieved by API call.
	let data: [User]
}
