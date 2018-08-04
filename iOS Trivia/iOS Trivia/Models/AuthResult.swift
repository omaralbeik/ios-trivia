//
//  AuthResult.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// Auth result model
public struct AuthResult: Codable {

	public var email: String
	public var localId: String
	public var idToken: String
	public var refreshToken: String

}
