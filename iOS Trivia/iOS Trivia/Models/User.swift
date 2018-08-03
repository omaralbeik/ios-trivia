//
//  User.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

public struct User: Codable {

	public var id: String
	public var email: String
	public var points: [String: Int] = [:]

	public var totalPoints: Int {
		return points.map({ $0.value }).reduce(0, +)
	}

}
