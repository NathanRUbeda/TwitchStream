//
//  ScheduleView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/23/24.
//

import SwiftUI

/// Displays a scrollable VStack containing a text and a series of buttons.
struct ScheduleView: View {
	let user: User
	
    var body: some View {
		ScrollView {
			VStack(alignment: .leading) {
				self.userIsLiveSection
				
				self.buttonsSection
			}
		}
	}
	
	/// Displays a text indicating the user is live.
	private var userIsLiveSection: some View {
		Text("\(user.displayName) is live!")
			.font(.largeTitle)
			.fontWeight(.bold)
	}
	
	/// Displays an HStack of buttons.
	private var buttonsSection: some View {
		HStack(spacing: 5) {
			self.todayButton
			
			ScheduleButton(
				imageSystemName: "chevron.left",
				fontWeight: .semibold,
				verticalPadding: 8,
				horizontalPadding: 15,
				backgroundColor: Color.gray
			)
			
			ScheduleButton(
				imageSystemName: "chevron.right",
				fontWeight: .semibold,
				verticalPadding: 8,
				horizontalPadding: 15,
				backgroundColor: Color.gray
			)
			
			ScheduleButton(
				imageSystemName: "calendar",
				fontWeight: .semibold,
				verticalPadding: 8,
				horizontalPadding: 6,
				backgroundColor: Color.gray
			)
		}
	}
	
	/// Displays a button labeled as a "Today" text.
	private var todayButton: some View {
		Button {
			// mock button
		} label: {
			Text("Today")
				.fontWeight(.medium)
				.padding(.vertical, 8)
				.padding(.horizontal, 16)
				.background(.red)
				.clipShape(RoundedRectangle(cornerRadius: 6))
		}
		.buttonStyle(.plain)
	}
}

#Preview {
	ScheduleView(user: .init(
						id: "5455",
						login: "SusBaka121",
						displayName: "SusBaka121",
						description: "Very sus",
						profileImageURL: "https://i.scdn.co/image/ab67616d00001e0237aa83334afa61c17331bde0",
						createdAt: "2020"
					))
}
