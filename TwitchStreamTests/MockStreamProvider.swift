//
//  MockStreamProvider.swift
//  TwitchStreamTests
//
//  Created by Nathan Ubeda on 12/3/24.
//

import ComposableArchitecturePattern
import Foundation
@testable import TwitchStream

/// An object that mimics an interaction with a cloud service using a JSON file.
actor MockStreamProvider: StreamProvidable {
	/// Fetches streams.
	/// - Returns: A `StreamResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchStreams() async throws -> StreamResponse {
		guard let jsonURL = Bundle(for: MockStreamProvider.self).url(forResource: "mockStreamJSON", withExtension: "json") else {
			throw NetworkError.missingJSON
		}
		
		guard let data = try? Data(contentsOf: jsonURL) else {
			throw NetworkError.loadingError
		}
		
		let decoder = JSONDecoder()
		return try decoder.decode(StreamResponse.self, from: data)
	}
	
	/// Fetches users based on their logins.
	/// - Parameters:
	/// - userLogins: An array of user logins.
	/// - Returns: A `UserResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchUsers(userLogins: [String]) async throws -> UserResponse {
		guard let jsonURL = Bundle(for: MockStreamProvider.self).url(forResource: "mockUsersJSON", withExtension: "json") else {
			throw NetworkError.missingJSON
		}
		
		guard let data = try? Data(contentsOf: jsonURL) else {
			throw NetworkError.loadingError
		}
		
		let decoder = JSONDecoder()
		return try decoder.decode(UserResponse.self, from: data)
	}
	
	/// Fetches videos based on the ID of the user.
	/// - Parameters:
	/// - userID: The ID of the user.
	/// - Returns: A `VideoResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchVideos(userID: String) async throws -> VideoResponse {
		let url: URL? = switch userID {
			case "48189727":
				Bundle(for: MockStreamProvider.self).url(forResource: "mockVideosID48189727JSON", withExtension: "json")
			case "119506529":
				Bundle(for: MockStreamProvider.self).url(forResource: "mockVideosID119506529JSON", withExtension: "json")
			case "203654142":
				Bundle(for: MockStreamProvider.self).url(forResource: "mockVideosID203654142JSON", withExtension: "json")
			default:
				nil
		}
		
		guard let jsonURL = url else {
			throw NetworkError.missingJSON
		}
		
		guard let data = try? Data(contentsOf: jsonURL) else {
			throw NetworkError.loadingError
		}
		
		let decoder = JSONDecoder()
		return try decoder.decode(VideoResponse.self, from: data)
	}
}
