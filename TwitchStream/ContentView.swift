//
//  ContentView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/16/24.
//

import SwiftUI

@Observable
class StreamViewModel {
	var isFetching = false
	var streams: [Stream]
	
	init(streams: [Stream] = []) {
		self.streams = streams
	}
}

struct ContentView: View {
	let streams: [Stream]
	
    var body: some View {
		ScrollView {
			ForEach(self.streams) { stream in
				StreamBadgeView(stream: stream)
			}
		}
    }
}

//#Preview {
//    ContentView()
//}
