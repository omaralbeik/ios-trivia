//
//  ErrorResult.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/4/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// Error result
struct ErrorResult: Codable {
	var code: Int
	var message: String
}
