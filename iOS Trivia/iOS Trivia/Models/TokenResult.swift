//
//  TokenResult.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// Token result model
public struct TokenResult: Codable {

	public var userId: String
	public var idToken: String
	public var refreshToken: String

}
