//
//  CustomTabBarView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import SwiftUI

/// Displays an HStack with a ForEach for tab views.
struct CustomTabBarView: View {
	let tabs: [TabBarItem]
	@Binding var selection: TabBarItem
	@Namespace private var namespace
	
    var body: some View {
		tabBarVersion
    }
}

extension CustomTabBarView {
	/// Displays an HStack with a ForEach for tab views.
	private var tabBarVersion: some View {
		HStack {
			ForEach(tabs, id: \.self) { tab in
				Spacer()
				
				tabView(tab: tab)
					.onTapGesture {
						switchToTab(tab: tab)
					}
				
				Spacer()
			}
		}
	}
	
	/// Creates a tab view.
	/// - Parameters:
	/// - tab: A TabBarItem.
	/// - Returns: some `View`.
	private func tabView(tab: TabBarItem) -> some View {
		Text(tab.title)
			.font(.title2)
			.foregroundStyle(selection == tab ? .purple : tab.color)
			.fontWeight(.semibold)
			.padding(.vertical, 5)
			.background(
				ZStack {
					if selection == tab {
						Rectangle()
							.frame(height: 2)
							.offset(y: 12)
							.foregroundStyle(.purple)
							.matchedGeometryEffect(id: "background_rectangle", in: namespace)
					}
				}
			)
	}
	
	/// Switches a TabBarItem selection to a new one.
	private func switchToTab(tab: TabBarItem) {
		withAnimation(.easeInOut) {
			selection = tab
		}
	}
}

#Preview {
	let tabs: [TabBarItem] = [
		.home, .about, .schedule, .videos, .chat
	]
	
	CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
}
