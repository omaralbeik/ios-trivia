//
//  APIError.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// API Errors.
///
/// - error: a known error.
/// - serverError: server error.
public enum APIError {
	case error(Error)
	case serverError(message: String)
}

extension APIError: LocalizedError {

	public var errorDescription: String? {
		switch self {
		case .error(let error):
			return error.localizedDescription
		case .serverError(let message):
			return message
		}
	}

	public var localizedDescription: String {
		switch self {
		case .error(let error):
			return error.localizedDescription
		case .serverError(let message):
			return message
		}
	}

}
