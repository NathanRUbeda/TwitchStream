//
//  TwitchUserAPI.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/22/24.
//

import ComposableArchitecturePattern
import Foundation

/// An object that specifies a server API.
struct TwitchUserAPI: ServerAPI {
	init(
		environment: ServerEnvironment?,
		path: String = "users",
		headers: [String : String]?,
		queries: [URLQueryItem]?,
		supportedHTTPMethods: [HTTPMethod] = [.GET],
		supportedReturnObjects: [any Codable.Type]? = [UserResponse.self],
		timeoutInterval: TimeInterval = 1000
	) {
		self.environment = environment
		self.path = path
		self.headers = headers
		self.queries = queries
		self.supportedHTTPMethods = supportedHTTPMethods
		self.supportedReturnObjects = supportedReturnObjects
		self.timeoutInterval = timeoutInterval
		self.strictEnvironmentEnforcement = false
	}

	let id = UUID()
	var environment: ServerEnvironment?
	var headers: [String : String]?
	var body: Data?
	var path: String
	var queries: [URLQueryItem]?
	var strictEnvironmentEnforcement: Bool
	var supportedHTTPMethods: [HTTPMethod]
	var supportedReturnObjects: [any Codable.Type]?
	var timeoutInterval: TimeInterval
}

