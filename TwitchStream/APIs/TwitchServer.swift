//
//  TwitchServer.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import ComposableArchitecturePattern
import Foundation
import OSLog

/// An actor that handles server interactions.
actor TwitchServer: Server {
	var environments: [ServerEnvironment]
	var additionalHTTPHeaders: [String : String]?
	var blockAllAPIsNotSupported: Bool = false
	var requestsBeingProcessed = Set<UUID>()
	var currentEnvironment: ServerEnvironment?
	var apis: [any ServerAPI]
	var logActivity: LogActivity
	
	init(
		environments: [ServerEnvironment],
		currentEnvironment: ServerEnvironment? = nil,
		additionalHTTPHeaders: [String : String]? = nil,
		supportedAPIs: [any ServerAPI],
		logActivity: LogActivity = .all
	) {
		self.environments = environments
		self.additionalHTTPHeaders = additionalHTTPHeaders
		self.currentEnvironment = currentEnvironment
		self.apis = supportedAPIs
		self.logActivity = logActivity
	}
	
	var logger: Logger {
		return Logger(subsystem: "TwitchServer", category: "TwitchStream")
	}
}
