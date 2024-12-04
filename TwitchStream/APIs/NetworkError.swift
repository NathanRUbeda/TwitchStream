//
//  NetworkError.swift
//  TwitchStream
//
//  Created by Nathan Ubeda on 12/2/24.
//

import Foundation

/// Enum of possible network errors.
enum NetworkError: Error {
	case invalidCredential
	case missingJSON
	case loadingError
}
