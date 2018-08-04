//
//  API.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

final class API {

	private init() {}

	static let authProvider = MoyaProvider<AuthService>()
	static let gameProvider = MoyaProvider<GameService>()
	static let userProvider = MoyaProvider<UserService>()

	static let apiKey = ["key": "AIzaSyB2DanM4vlas94SmDFQlTKmFfI1GKmQAQg"]

	static func authParameters(for idToken: String) -> [String: String] {
		return ["auth": idToken]
	}

}
