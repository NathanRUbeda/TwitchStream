//
//  TwitchStreamProvider.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import ComposableArchitecturePattern
import SwiftUI

protocol StreamProvidable {
	func fetchStreams() async throws -> StreamResponse
}

actor TwitchStreamProvider: StreamProvidable {
	static let currentEnvironment = ServerEnvironment.production(url: "https://api.twitch.tv/helix")
	static let authEnvironment = ServerEnvironment.production(url: "https://id.twitch.tv/oauth2")
	static let supportedEnvironments = [currentEnvironment, authEnvironment]
	
	static let streamAPI = TwitchStreamAPI(
		environment: currentEnvironment,
		headers: nil,
		queries: nil
	)
	static let authAPI = TwitchAuthAPI(
		environment: authEnvironment,
		headers: ["Content-Type": "application/x-www-form-urlencoded"],
		queries: nil
	)
	
	lazy var server = TwitchServer(
		environments: Self.supportedEnvironments,
		currentEnvironment: Self.currentEnvironment,
		supportedAPIs: [Self.streamAPI, Self.authAPI]
	)
	
	private var credential: Credential? // TODO: Should try to use AppStorage (could come with conversion issues for AppStorage) or SwiftData. Using SwiftData would require you to set up the mechanisms for fetching and updating.
	private var isValid: Bool {
		guard let credential else {
			return false
		}
		return credential.expiresAt > Date.now
	}
	
	func fetchStreams() async throws -> StreamResponse {
		if !self.isValid {
			self.credential = try await self._getCredentials()
		}
		guard self.isValid else {
			throw TwitchError.invalidCredential
		}
		let additionalHeaders = try await self._additionalHeaders()
		print("***** additionalHeaders: \(additionalHeaders)")
		let response: StreamResponse = try await self.server.get(
			Self.streamAPI, additionalHeaders: additionalHeaders)
		return response
	}
	
	private func _additionalHeaders() async throws -> [String: String] {
		guard let credential else {
			throw TwitchError.invalidCredential
		}
		guard let clientID = ProcessInfo.processInfo.environment["API_Client_ID"] else {
			throw ServerAPIError.badRequest(description: "Must have clientID available.", error: nil)
		}
		
		return [
			"Authorization" : "Bearer \(credential.accessToken)",
			"Client-Id" : "\(clientID)"
		]
	}
	
	private func _getCredentials() async throws -> Credential {
		let credential: Credential = try await self.server.post(Self.authAPI)
		return credential
	}
}

enum TwitchError: Error {
	case invalidCredential
}


