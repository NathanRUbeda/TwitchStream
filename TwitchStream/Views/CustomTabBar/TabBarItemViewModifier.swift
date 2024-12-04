//
//  TabBarItemViewModifier.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/3/24.
//

import Foundation
import SwiftUI

/// A view modifier for TabBarItem.
struct TabBarItemViewModifier: ViewModifier {
	let tab: TabBarItem
	@Binding var selection: TabBarItem
	
	/// Creates a new view based on a previous value.
	func body(content: Content) -> some View {
		content
			.opacity(selection == tab ? 1.0 : 0.0)
			.preference(key: TabBarItemsPreferenceKey.self, value: [tab])
	}
}
