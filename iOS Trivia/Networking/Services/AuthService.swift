//
//  AuthService.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

/// AuthService
///
/// - register: register new user.
/// - login: login as existing user.
/// - getIdToken: get an id token from a refresh tokem
enum AuthService {
	case register(email: String, password: String)
	case login(email: String, password: String)
	case getIdToken(refreshToken: String)
}

// MARK: - TargetType
extension AuthService: TargetType {

	var baseURL: URL {
		switch self {
		case .register,
			 .login:
			return URL(string: "https://www.googleapis.com/identitytoolkit/v3/relyingparty")!
		case .getIdToken:
			return URL(string: "https://securetoken.googleapis.com/v1")!
		}

	}

	var path: String {
		switch self {
		case .register:
			return "signupNewUser"
		case .login:
			return "verifyPassword"
		case .getIdToken:
			return "token"
		}
	}

	var method: Moya.Method {
		switch self {
		case .register,
			 .login,
			 .getIdToken:
			return .post
		}
	}

	var task: Task {
		switch self {
		case .register(let email, let password),
			 .login(let email, let password):
			let bodyParameters = [
				"email": email,
				"password": password,
				"returnSecureToken": "true"
			]
			return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: API.apiKey)

		case .getIdToken(let refreshToken):
			let bodyParameters = [
				"grant_type": "refresh_token",
				"refresh_token": refreshToken
			]
			return .requestCompositeParameters(bodyParameters: bodyParameters, bodyEncoding: JSONEncoding.default, urlParameters: API.apiKey)
		}
	}

	var headers: [String: String]? { return nil }
	var sampleData: Data { return "".utf8Encoded }

}
