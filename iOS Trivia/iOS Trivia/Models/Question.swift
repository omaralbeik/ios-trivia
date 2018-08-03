//
//  Question.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

public struct Question: Codable {

	public var id: String
	public var text: String
	public var duration: TimeInterval
	public var points: Int
	public var answers: [Answer]

}
