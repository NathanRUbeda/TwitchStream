//
//  TwitchStreamApp.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import SwiftUI

@main
struct TwitchStreamApp: App {
	let twitchStreamProvider = TwitchStreamProvider()
	var viewModel = StreamViewModel()
	
	init() {
		self._fetchInitialStreams()
	}
	
    var body: some Scene {
        WindowGroup {
			ContentView(streams: self.viewModel.streams)
        }
    }
	
	private func _fetchInitialStreams() {
		Task {
			do {
				let streams = try await self._fetchStreams()
				self.viewModel.streams = streams
			} catch {
				print(error)
			}
		}
	}
	
	private func _fetchStreams() async throws -> [Stream] {
		defer {
			self.viewModel.isFetching = false
		}
		self.viewModel.isFetching = true
		let response = try await self.twitchStreamProvider.fetchStreams()
		return response.data
	}
	
//	private func _getCredentials() async throws -> Credential {
//		let body = "client_id=3tkclsjks11mkk6y4vg7rbc0c4agrp&client_secret=4xkuay25d1zfy1x99c0x7b7q7l6ota&grant_type=client_credentials"
//		let jsonData = try? JSONSerialization.data(withJSONObject: body)
//		
//		var request = URLRequest(
//			url: URL(string: "https://id.twitch.tv/oauth2/token")!)
//		request.httpMethod = "POST"
//		request.httpBody = jsonData
//		let (data, _) = try await URLSession.shared.data(for: request)
//		let decodedToken = try JSONDecoder().decode(Credential.self, from: data)
//		return decodedToken
//	}
}
