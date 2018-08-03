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

	private init() {}

	public static let authProvider = MoyaProvider<AuthService>()
	public static let gameProvider = MoyaProvider<GameService>()
	public static let userProvider = MoyaProvider<UserService>()

	public static let apiKey = ["key": "AIzaSyB2DanM4vlas94SmDFQlTKmFfI1GKmQAQg"]

}
