//
//  TwitchFollowerAPI.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/25/24.
//

import ComposableArchitecturePattern
import Foundation

/// An object that specifies a server API.
struct TwitchFollowerAPI: ServerAPI {
	init(
		environment: ServerEnvironment?,
		path: String = "channels/followers",
		headers: [String : String]?,
		queries: [URLQueryItem]?,
		supportedHTTPMethods: [HTTPMethod] = [.GET],
		supportedReturnObjects: [any Codable.Type]? = [FollowerResponse.self],
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

