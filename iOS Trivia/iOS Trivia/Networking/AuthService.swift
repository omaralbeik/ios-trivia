//
//  AuthService.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

public enum AuthService {
	case register(email: String, password: String)
	case login(email: String, password: String)
	case getIdToken(refreshToken: String)
}

extension AuthService: TargetType {

	public var baseURL: URL {
		switch self {
		case .register,
			 .login:
			return URL(string: "https://www.googleapis.com/identitytoolkit/v3/relyingparty")!
		case .getIdToken:
			return URL(string: "https://securetoken.googleapis.com/v1")!
		}

	}

	public var path: String {
		switch self {
		case .register:
			return "signupNewUser"
		case .login:
			return "verifyPassword"
		case .getIdToken:
			return "token"
		}
	}

	public var method: Moya.Method {
		switch self {
		case .register,
			 .login,
			 .getIdToken:
			return .post
		}
	}

	public var task: Task {
		switch self {
		case .register(let email, let password),
			 .login(let email, let password):
			let parameters = [
				"email": email,
				"password": password,
				"returnSecureToken": "true"
			]
			return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: JSONEncoding.default, urlParameters: API.apiKey)

		case .getIdToken(let refreshToken):
			let parameters = [
				"grant_type": "refresh_token",
				"refresh_token": refreshToken
			]
			return .requestCompositeParameters(bodyParameters: parameters, bodyEncoding: JSONEncoding.default, urlParameters: API.apiKey)
		}
	}

	public var headers: [String: String]? { return nil }
	public var sampleData: Data { return "".utf8Encoded }

}

// MARK: - Mapping
extension Response {

	var authResult: AuthResult? {
		return try? map(AuthResult.self, using: DefaultDecoder())
	}

	var tokenResult: TokenResult? {
		return try? map(TokenResult.self, using: DefaultDecoder())
	}

}
