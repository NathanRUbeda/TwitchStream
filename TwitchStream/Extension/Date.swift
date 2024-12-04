//
//  Date.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/3/24.
//

import Foundation

extension Date {
	/// Calculates the time difference between a certain Date and now, and formats it accordingly.
	/// - Returns: A `String` object.
	func timeAgoDisplay() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .full
		return formatter.localizedString(for: self, relativeTo: Date())
	}
}
