//
//  Credential.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 10/18/24.
//

import Foundation

/// An object that represents a credential.
struct Credential: Codable {
	/// The access token for the API.
	let accessToken: String
	
	/// The expiring data of the access token.
	let expiresAt: Date
	
	/// The type of the token.
	let tokenType: String
	
	enum CodingKeys: String, CodingKey {
		case accessToken = "access_token"
		case expiresIn = "expires_in"
		case tokenType = "token_type"
	}
	
	/// Encodes data.
	func encode(to encoder: any Encoder) throws { }
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.accessToken = try container
			.decode(String.self, forKey: .accessToken)
		let expiresIn = try container.decode(Int.self, forKey: .expiresIn)
		self.expiresAt = Date().addingTimeInterval(TimeInterval(expiresIn))
		self.tokenType = try container.decode(String.self, forKey: .tokenType)
	}
}
