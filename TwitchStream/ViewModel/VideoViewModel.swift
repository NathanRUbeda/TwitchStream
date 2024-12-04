//
//  VideoViewModel.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// An object that is used to model Video data with a view.
@Observable
class VideoViewModel {
	/// Checks if viewModel is done fetching or not.
	var isFetching = false
	
	/// Array of videos.
	var videos: [Video]
	
	init(videos: [Video] = []) {
		self.videos = videos
	}
}
