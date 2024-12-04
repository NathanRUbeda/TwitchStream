//
//  VideoResponse.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that represents a network response containing an array of videos.
struct VideoResponse: Codable {
	/// Array of videos retrivied by API call.
	let data: [Video]
}
