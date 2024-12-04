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
	var userViewModel = UserViewModel()
	
	init() {
		self._fetchInitialStreamsAndUsers()
	}
	
    var body: some Scene {
        WindowGroup {
			ContentView(
				streams: self.viewModel.streams,
				users: self.userViewModel.users)
        }
    }
	
	/// Fetches streams and users for initial view.
	private func _fetchInitialStreamsAndUsers() {
		Task {
			do {
				let streams = try await self._fetchStreams()
				self.viewModel.streams = streams
				
				var userLogins = [String]()
				for stream in self.viewModel.streams {
					userLogins.append(stream.userLogin)
				}
				
				if userLogins.isEmpty {
					print("Error: userLogins is empty.")
					print("There's \(viewModel.streams.count) streams")
				} else {
					print("Success -logins acquired.")
				}
				
				let users = try await self.fetchUsers(
					userLogins: userLogins)
				self.userViewModel.users = users
			} catch {
				print(error)
			}
		}
	}
	
	/// Fetches streams.
	/// - Returns: An array of `Stream` objects.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	private func _fetchStreams() async throws -> [Stream] {
		defer {
			self.viewModel.isFetching = false
		}
		self.viewModel.isFetching = true
		let response = try await self.twitchStreamProvider.fetchStreams()
		
		return response.data
	}
	
	/// Fetches users based on their logins.
	/// - Parameters:
	/// - userLogins: An array of user logins.
	/// - Returns: An array of `User` objects.
	/// - Throws: A `NetworkError` if encountered during processing of request.
	private func fetchUsers(userLogins: [String]) async throws -> [User] {
		defer {
			self.userViewModel.isFetching = false
		}
		self.userViewModel.isFetching = true
		let response = try await self.twitchStreamProvider.fetchUsers(
			userLogins: userLogins
		)
		return response.data
	}
}
