//
//  Question.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

struct Question: Codable {

	var id: String
	var text: String
	var answers: [Answer]

	static var test = Question(id: "1", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua", answers: [
		Answer(text: "H2O", isCorrect: false),
		Answer(text: "H2O", isCorrect: false),
		Answer(text: "H2O", isCorrect: false),
		Answer(text: "H2O", isCorrect: true)
		])

}
