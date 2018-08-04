//
//  Button.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class Button: UIButton {

	convenience init(title: String, backgroundColor: UIColor? = Color.white, tintColor: UIColor? = Color.darkOrange) {
		self.init(type: .system)

		setStyle(backgroundColor: backgroundColor, tintColor: tintColor)
		setTitle(title, for: .normal)
	}

}

// MARK: - Layoutable
extension Button: Layoutable {

	var preferredPadding: CGFloat {
		return 6.0
	}

}

// MARK: - Stylable
extension Button: Stylable {

	func setStyle(backgroundColor: UIColor?, tintColor: UIColor?) {
		self.backgroundColor = backgroundColor
		imageView?.backgroundColor = backgroundColor
		titleLabel?.backgroundColor = backgroundColor
		titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
		if let color = tintColor {
			self.tintColor = color
		}
		contentEdgeInsets = .init(top: 0, left: preferredPadding * 3, bottom: 0, right: preferredPadding * 3)
		layer.cornerRadius = preferredPadding

	}

}

// MARK: - Loadingable
extension Button: Loadingable {

	var indicatorTintColor: UIColor? {
		return Color.darkOrange
	}

	var indicatorBackgroundColor: UIColor? {
		return Color.white
	}

	var indicatorAlpha: CGFloat {
		return 1
	}

	var indicatorSize: CGSize {
		return frame.size
	}

	var indicatorPadding: CGFloat {
		return 3
	}

	var indicatorCornerRadius: CGFloat {
		return preferredPadding
	}

}
