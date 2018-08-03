//
//  API.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation
import Moya

public struct API {

	public static let authProvider = MoyaProvider<AuthService>()
	public static let gameProvider = MoyaProvider<GameService>()

	static let apiKey = ["key": "AIzaSyB2DanM4vlas94SmDFQlTKmFfI1GKmQAQg"]
//	static let baseHeaders = ["Content-Type": "application/json"]

}

extension String {

	var utf8Encoded: Data {
		return data(using: .utf8)!
	}

}
