//
//  StreamResponse.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that represents a network response containing an array of streams.
struct StreamResponse: Codable {
	/// Array of streams retrivied from the API call.
	let data: [Stream]
}
