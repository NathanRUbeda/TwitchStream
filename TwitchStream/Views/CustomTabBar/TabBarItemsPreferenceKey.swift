//
//  TabBarItemsPreferenceKey.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import Foundation
import SwiftUI

/// A named value produced by a view.
struct TabBarItemsPreferenceKey: PreferenceKey {
	/// The default value of the preference.
	static var defaultValue: [TabBarItem] = []
	
	/// Combines a sequence of values by modifying the previously-accumulated value with the result of a closure that provides the next value.
	/// - Parameters:
	/// - value: The value accumulated through previous calls to this method.
	/// - nextValue: A closure that returns the next value in the sequence.
	static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
		value += nextValue()
	}
}
