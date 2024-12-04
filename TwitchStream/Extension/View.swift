//
//  View.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/3/24.
//

import Foundation
import SwiftUI

extension View {
	func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
		modifier(TabBarItemViewModifier(tab: tab, selection: selection))
	}
}
