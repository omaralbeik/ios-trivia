//
//  Color.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class Color: UIColor {

	convenience init(hex: Int) {
		let components = (
			R: CGFloat((hex >> 16) & 0xff) / 255,
			G: CGFloat((hex >> 08) & 0xff) / 255,
			B: CGFloat((hex >> 00) & 0xff) / 255
		)
		self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
	}

	static let lightYellow = Color(hex: 0xFFCF55)
	static let darkYellow = Color(hex: 0xF6BB43)

	static let lightBlack = Color(hex: 0x303030)
	static let darkBlack = Color(hex: 0x171717)

	override static var lightGray: Color {
		return Color(hex: 0xF6F7FB)
	}
	override static var darkGray: Color {
		return Color(hex: 0xAAB2BD)
	}

	static let lightOrange = Color(hex: 0xFB6E52)
	static let darkOrange = Color(hex: 0xE9573E)

}
