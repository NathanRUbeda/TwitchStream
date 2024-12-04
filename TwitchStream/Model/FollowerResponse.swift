//
//  FollowerResponse.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that represents a network response containing an array of followers.
struct FollowerResponse: Codable {
	/// Array of followers retrivied by API call.
	let data: [Follower]
	
	/// Total amount of user's followers.
	let total: Int
}
