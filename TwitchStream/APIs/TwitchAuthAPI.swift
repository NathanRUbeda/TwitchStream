//
//  TwitchAuthAPI.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/18/24.
//

import ComposableArchitecturePattern
import Foundation

struct TwitchAuthAPI: ServerAPI {

	init(
		environment: ServerEnvironment?,
		path: String = "token",
		headers: [String : String]?,
		queries: [URLQueryItem]?,
		supportedHTTPMethods: [HTTPMethod] = [.POST],
		supportedReturnObjects: [any Codable.Type]? = [Credential.self],
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
		
		if let clientID = ProcessInfo.processInfo.environment["API_Client_ID"],
		   let clientSecret = ProcessInfo.processInfo.environment["API_Client_Secret"] {
			let grantType = "client_credentials"
			
			let body = "client_id=\(clientID)&client_secret=\(clientSecret)&grant_type=\(grantType)".data(using: .utf8)!
			self.body = body
		}
	}
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.id == rhs.id
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
