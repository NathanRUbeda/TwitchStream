//
//  TwitchStreamProvider.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import ComposableArchitecturePattern
import SwiftUI

/// An object that interacts with a cloud service.
actor TwitchStreamProvider: StreamProvidable {
	static let currentEnvironment = ServerEnvironment.production(url: "https://api.twitch.tv/helix")
	static let authEnvironment = ServerEnvironment.production(url: "https://id.twitch.tv/oauth2")
	static let supportedEnvironments = [currentEnvironment, authEnvironment]
	
	
	static let authAPI = TwitchAuthAPI(
		environment: authEnvironment,
		headers: ["Content-Type": "application/x-www-form-urlencoded"],
		queries: nil
	)
	
	static let followerAPI = TwitchFollowerAPI(
		environment: currentEnvironment,
		headers: nil,
		queries: nil
	)
	
	static let streamAPI = TwitchStreamAPI(
		environment: currentEnvironment,
		headers: nil,
		queries: nil
	)
	
	static let userAPI = TwitchUserAPI(
		environment: currentEnvironment,
		headers: nil,
		queries: nil
	)
	
	static let videoAPI = TwitchVideoAPI(
		environment: currentEnvironment,
		headers: nil,
		queries: nil
	)
	
	lazy var server = TwitchServer(
		environments: Self.supportedEnvironments,
		currentEnvironment: Self.currentEnvironment,
		supportedAPIs: [
			Self.authAPI,
			Self.streamAPI,
			Self.userAPI,
			Self.videoAPI
		]
	)
	
	private var credential: Credential?
	private var isValid: Bool {
		guard let credential else {
			return false
		}
		return credential.expiresAt > Date.now
	}
	
	/// Fetches followers based on the broadcaster's id.
	/// - Parameters:
	/// - broadcasterID: The ID of the broadcaster.
	/// - Returns: A `FollowerResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchFollowers(broadcasterID: String) async throws -> FollowerResponse {
		if !self.isValid {
			self.credential = try await self._getCredentials()
		}
		guard self .isValid else {
			throw NetworkError.invalidCredential
		}
		let additionalHeaders = try await self._additionalHeaders()
		let querie = [URLQueryItem(name: "broadcaster_id", value: broadcasterID)]
		let response: FollowerResponse = try await self.server.get(
			Self.followerAPI, additionalHeaders: additionalHeaders, queries: querie)
		return response
	}
	
	/// Fetches streams.
	/// - Returns: A `StreamResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchStreams() async throws -> StreamResponse {
		if !self.isValid {
			self.credential = try await self._getCredentials()
		}
		guard self.isValid else {
			throw NetworkError.invalidCredential
		}
		let additionalHeaders = try await self._additionalHeaders()
		print("***** additionalHeaders: \(additionalHeaders)")
		let response: StreamResponse = try await self.server.get(
			Self.streamAPI, additionalHeaders: additionalHeaders)
		return response
	}
	
	/// Fetches users based on their logins.
	/// - Parameters:
	/// - userLogins: An array of user logins.
	/// - Returns: A `UserResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchUsers(userLogins: [String]) async throws -> UserResponse {
		if !self.isValid {
			self.credential = try await self._getCredentials()
		}
		guard self.isValid else {
			throw NetworkError.invalidCredential
		}
		let additionalHeaders = try await self._additionalHeaders()
		
		var queries = [URLQueryItem]()
		for userLogin in userLogins {
			let querie = URLQueryItem(name: "login", value: userLogin)
			queries.append(querie)
		}
		
		// testing
		if queries.isEmpty {
			print("Error: Queries is empty.")
			print("There's \(userLogins.count) logins")
		} else {
			print("Success - queries acquired.")
		}
		
		let response: UserResponse = try await self.server.get(Self.userAPI, additionalHeaders: additionalHeaders, queries: queries)
		return response
	}
	
	/// Fetches videos based on the ID of the user.
	/// - Parameters:
	/// - userID: The ID of the user.
	/// - Returns: A `VideoResponse` object.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	func fetchVideos(userID: String) async throws -> VideoResponse {
		if !self.isValid {
			self.credential = try await self._getCredentials()
		}
		guard self .isValid else {
			throw NetworkError.invalidCredential
		}
		let additionalHeaders = try await self._additionalHeaders()
		let response: VideoResponse = try await self.server.get(Self.videoAPI, additionalHeaders: additionalHeaders, queries: [.init(name: "user_id", value: userID)])
		return response
		
	}
	
	/// Creates additional query items.
	/// - Returns: A dictionary.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	private func _additionalHeaders() async throws -> [String: String] {
		guard let credential else {
			throw NetworkError.invalidCredential
		}
		guard let clientID = ProcessInfo.processInfo.environment["API_Client_ID"] else {
			throw ServerAPIError.badRequest(description: "Must have clientID available.", error: nil)
		}
		
		return [
			"Authorization" : "Bearer \(credential.accessToken)",
			"Client-Id" : "\(clientID)"
		]
	}
	
	/// Fetches credentials from the network.
	/// - Returns: A `Credential` object.
	/// - Throws: A `ServerAPIError` if encountered during processing of request.
	private func _getCredentials() async throws -> Credential {
		let credential: Credential = try await self.server.post(Self.authAPI)
		return credential
	}
}




