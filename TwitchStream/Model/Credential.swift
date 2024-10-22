//
//  Credential.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/18/24.
//

import Foundation

struct Credential: Codable {
	let accessToken: String
	let expiresAt: Date
	let tokenType: String
	
	enum CodingKeys: String, CodingKey {
		case accessToken = "access_token"
		case expiresIn = "expires_in"
		case tokenType = "token_type"
	}
	
	func encode(to encoder: any Encoder) throws {
	}
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.accessToken = try container
			.decode(String.self, forKey: .accessToken)
		// Start - This is why we have to customize the decoder for this object.
		let expiresIn = try container.decode(Int.self, forKey: .expiresIn) // You may find this to be a double. If this fails or doesn't work correctly, change it to `Double`.
		self.expiresAt = Date().addingTimeInterval(TimeInterval(expiresIn))
		// End
		self.tokenType = try container.decode(String.self, forKey: .tokenType)
	}
}
