//
//  Question.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct Question: Codable {
	var id: Int
	var text: String
	var points: Int
	var answers: [Answer]
}
