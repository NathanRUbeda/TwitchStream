//
//  Int.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 11/28/24.
//

import Foundation

extension Int {
	/// Formats an Int as a String, abbreviating decimal places when necessary.
	var asFormattedString: String {
		let number = self
		
		switch number {
			case 0..<1000:
				return "\(number)"
			case 1000..<1000000:
				return "\(number / 1000)K"
			case 1000000..<1000000000:
				return "\(number / 1000000)M"
			case 1000000000..<1000000000000:
				return "\(number / 1000000000)B"
			default:
				return "\(number)"
		}
	}
}
