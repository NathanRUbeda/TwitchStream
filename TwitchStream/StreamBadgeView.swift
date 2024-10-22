//
//  StreamBadgeView.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/17/24.
//

import SwiftUI

struct StreamBadgeView: View {
	let stream: Stream
	
    var body: some View {
			VStack {
				AsyncImage(url: URL(string: stream.thumbnailURL)) { image in
					image
						.resizable()
						.scaledToFit()
						.frame(width: 350, height: 200)
						.overlay(alignment: .topLeading) {
							Text("LIVE")
								.foregroundStyle(.white)
								.font(.headline)
								.fontWeight(.bold)
								.padding(.horizontal, 6)
								.padding(.vertical, 2)
								.background(
									RoundedRectangle(cornerRadius: 5)
										.fill(.red)
								)
						}
						.overlay(alignment: .bottomLeading) {
							Text("\(stream.viewerCount) viewers")
								.foregroundStyle(.white)
								.font(.body)
								.fontWeight(.semibold)
								.padding(3)
								.background(
									RoundedRectangle(cornerRadius: 5)
										.opacity(0.5)
								)
						}
				} placeholder: {
					ProgressView()
				}
				
				HStack(alignment: .top) {
					Image("mockPhoto")
						.resizable()
						.frame(width: 50, height: 50)
						.clipShape(Circle())
						
					
					VStack(alignment: .leading) {
						Text(stream.title)
							.fontWeight(.bold)
							.textCase(.uppercase)
							.frame(width: 250)
							.lineLimit(1)
						
						Text(stream.userName)
							.font(.body)
						
						Text(stream.gameName)
							.font(.body)
						
						HStack {
							ForEach(stream.tags, id: \.self) { tag in
								Text(tag)
									.font(.callout)
									.fontWeight(.semibold)
									.padding(.horizontal, 12)
									.padding(.vertical, 4)
									.background(
										Capsule()
											.fill(.gray)
									)
							}
						}
					}
					
					Button {
						
					} label: {
						Image(systemName: "ellipsis")
							.rotationEffect(.degrees(90))
					}
				}
			}
    }
}

#Preview {
	StreamBadgeView(
		stream: .init(
			id: "555",
			userID: "5445",
			userName: "SusBaka121",
			gameName: "Among Us",
			type: "live",
			title: "Playing AMOGUS - Who's The Impostor???",
			tags: ["English", "Gaming"],
			viewerCount: 100,
			language: "English",
			thumbnailURL: "https://wallpapers.com/images/featured/among-us-cb21ldue3llceiua.jpg"
		)
	)
}
