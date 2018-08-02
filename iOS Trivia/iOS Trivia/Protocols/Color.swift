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

	static let softYellow = Color(hex: 0xF9D170)
	static let softGray = Color(hex: 0xF2F2F2)

}
