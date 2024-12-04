//
//  FollowerVideoModel.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that is used to model Follower data with a view.
@Observable
class FollowerViewModel {
	/// Checks if viewModel is done fetching or not.
	var isFetching = false
	
	/// Total amount of followers.
	var totalFollowers: Int
	
	init(totalFollowers: Int = 0) {
		self.totalFollowers = totalFollowers
	}
}
