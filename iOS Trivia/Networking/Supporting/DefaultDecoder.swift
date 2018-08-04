//
//  DefaultDecoder.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// DefaultDecoder
final public class DefaultDecoder: JSONDecoder {

	override init() {
		super.init()

		keyDecodingStrategy = .convertFromSnakeCase
	}

}
