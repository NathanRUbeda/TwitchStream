//
//  CustomTabBarContainerView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import SwiftUI

/// Displays a VStack with a custom TabBar that acts as a container.
struct CustomTabBarContainerView<Content: View>: View {
	@Binding var selection: TabBarItem
	let content: Content
	@State private var tabs: [TabBarItem] = []
	
	init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
		self._selection = selection
		self.content = content()
	}
	
    var body: some View {
		VStack(spacing: 0) {
			CustomTabBarView(tabs: tabs, selection: $selection)
			
			ZStack {
				content
			}
		}
		.onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in self.tabs = value
		})
    }
}

#Preview {
	let tabs: [TabBarItem] = [
		.home, .about, .schedule, .videos, .chat
	]
	
	CustomTabBarContainerView(selection: .constant(tabs.first!)) {
		Color.red
	}
}
