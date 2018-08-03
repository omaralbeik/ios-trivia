//
//  ErrorResult.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct ErrorResult: Codable {
	var code: Int
	var message: String
}
