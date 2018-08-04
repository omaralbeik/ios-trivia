//
//  User.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// User model
public struct User: Codable {

	public var id: String
	public var email: String
	public var points: [String: Int]?

	public var totalPoints: Int {
		return points?.map({ $0.value }).reduce(0, +) ?? 0
	}

}

// MARK: - Equatable
extension User: Equatable {

	public static func == (lhs: User, rhs: User) -> Bool {
		return lhs.id == rhs.id
	}

}

// MARK: - Comparable
extension User: Comparable {

	public static func < (lhs: User, rhs: User) -> Bool {
		return lhs.totalPoints < rhs.totalPoints
	}

}
