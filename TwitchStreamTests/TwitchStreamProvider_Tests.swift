//
//  TwitchStreamProvider_Tests.swift
//  TwitchStreamTests
//
//  Created by Nathan Ubeda on 12/4/24.
//

import XCTest
@testable import TwitchStream

final class TwitchStreamProvider_Tests: XCTestCase {
	var streamProvider: StreamProvidable?
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		streamProvider = MockStreamProvider()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func test_StreamProvider_fetchStreams_shouldFetchStreams() async throws {
		// Given
		guard let streamProvider else {
			XCTFail()
			return
		}
		
		// When
		let response = try await streamProvider.fetchStreams()
		
		// Then
		XCTAssertNotNil(response)
	}
	
	func test_StreamProvider_fetchUsers_shouldFetchUsers() async throws {
		// Given
		guard let streamProvider else {
			XCTFail()
			return
		}
		
		// When
		let response = try await streamProvider.fetchUsers(userLogins: ["darumaisgod", "fps_shaka", "evelone2004", "kato_junichi0817", "rader", "kanae_2434", "k4sen", "montanablack88", "stylishnoob4", "jeanmassiet", "worldoftanks", "piratesoftware", "recrent", "t2x2", "fantasista_jp", "cdawgva", "leagol0vach", "wenlobong", "peintooon", "esfandtv"])
		
		// Then
		XCTAssertNotNil(response)
	}
	
	func test_StreamProvider_fetchVideos_shouldFetchSpecificUserVideos() async throws {
		// Given
		guard let streamProvider else {
			XCTFail()
			return
		}
		
		// When
		let userIDS = ["48189727", "119506529", "203654142"]
		
		// Then
		for userID in userIDS {
			let response = try await streamProvider.fetchVideos(userID: userID)
			XCTAssertNotNil(response)
		}
	}

}
