//
//  StreamProvidable.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that provides streams and related data.
protocol StreamProvidable {
	/// Sends request to get streams.
	/// - Returns: A `StreamResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchStreams() async throws -> StreamResponse
	
	/// Fetches users based on their logins.
	/// - Parameters:
	/// - userLogins: An array of user logins.
	/// - Returns: A `UserResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchUsers(userLogins: [String]) async throws -> UserResponse
	
	/// Fetches videos based on the ID of the user.
	/// - Parameters:
	/// - userID: The ID of the user.
	/// - Returns: A `VideoResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchVideos(userID: String) async throws -> VideoResponse
}
