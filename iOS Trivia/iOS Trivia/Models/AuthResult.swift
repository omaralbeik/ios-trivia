//
//  AuthResult.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct AuthResult: Codable {
	var email: String
	var localId: String
	var idToken: String
	var refreshToken: String
}
