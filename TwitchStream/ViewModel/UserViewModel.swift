//
//  UserViewModel.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that is used to model User data with a view.
@Observable
class UserViewModel {
	/// Checks if viewModel is done fetching or not.
	var isFetching = false
	
	/// Array of users.
	var users: [User]
	
	init(users: [User] = []) {
		self.users = users
	}
}
