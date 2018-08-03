//
//  AuthCache.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

final class AuthCache {

	private init() {}
	private static var defaults = UserDefaults.standard

	static var idToken: String? {
		guard isAuthenticated else { return nil }
		return defaults.string(forKey: Keys.idToken.rawValue)
	}

	static var refreshToken: String? {
		return defaults.string(forKey: Keys.refreshToken.rawValue)
	}

	static var idTokenExpiryDate: Date? {
		return defaults.value(forKey: Keys.idTokenExpiryDate.rawValue) as? Date
	}

	static var isAuthenticated: Bool {
		guard refreshToken != nil else { return false }
		guard let date = idTokenExpiryDate else { return false }
		return date > Date()
	}

	static var hasRefreshToken: Bool {
		return refreshToken != nil
	}

	static func saveAuthResult(_ authResult: AuthResult) {
		saveTokens(refreshToken: authResult.refreshToken, idToken: authResult.idToken)
	}

	static func saveTokenResult(_ tokenResult: TokenResult) {
		saveTokens(refreshToken: tokenResult.refreshToken, idToken: tokenResult.idToken)
	}

	private static func saveTokens(refreshToken: String, idToken: String) {
		defaults.set(idToken, forKey: Keys.idToken.rawValue)
		defaults.set(refreshToken, forKey: Keys.refreshToken.rawValue)

		let expiryDate = Date().addingTimeInterval(3600)
		defaults.set(expiryDate, forKey: Keys.idTokenExpiryDate.rawValue)
	}

}

private extension AuthCache {

	enum Keys: String {
		case idToken = "id_token"
		case refreshToken = "refresh_token"
		case idTokenExpiryDate = "id_token_expiry_date"
	}

}
