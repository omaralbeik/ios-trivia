//
//  Button.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class Button: UIButton {

	convenience init(title: String) {
		self.init(type: .system)

		setStyle()
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

	func setStyle() {
		backgroundColor = Color.white
		titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
		tintColor = Color.darkOrange
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
