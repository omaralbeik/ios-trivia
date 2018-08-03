//
//  TokenResult.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct TokenResult: Codable {
	var userId: String
	var idToken: String
	var refreshToken: String
}
