//
//  StreamViewModel.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that is used to model Stream data with a view.
@Observable
class StreamViewModel {
	/// Checks if viewModel is done fetching or not.
	var isFetching = false
	
	/// Array of streams.
	var streams: [Stream]
	
	init(streams: [Stream] = []) {
		self.streams = streams
	}
}
