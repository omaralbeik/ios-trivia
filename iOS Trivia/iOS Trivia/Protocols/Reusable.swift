//
//  Reusable.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/4/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// Conform to Reusable in reusable objects.
protocol Reusable {

	/// Reuse identifier
	static var reuseIdentifier: String { get }

}
