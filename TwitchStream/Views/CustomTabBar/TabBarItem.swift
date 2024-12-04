//
//  TabBarItem.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import Foundation
import SwiftUI

/// Enum of TabBarItem variables.
enum TabBarItem: Hashable {
	case home, about, schedule, videos, chat
	
	var title: String {
		switch self {
			case .home: return "Home"
			case .about: return "About"
			case .schedule: return "Schedule"
			case .videos: return "Videos"
			case .chat: return "Chat"
		}
	}
	
	var color: Color {
		switch self {
			case .home: return Color.black
			case .about: return Color.black
			case .schedule: return Color.black
			case .videos: return Color.black
			case .chat: return Color.black
		}
	}
}
