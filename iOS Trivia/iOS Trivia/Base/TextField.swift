//
//  TextField.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class TextField: UITextField {

	enum TextType {
		case email
		case password
	}

	convenience init(placeholder: String?, text: String? = nil, textType: TextType) {
		self.init()

		setStyle()
		self.placeholder = placeholder
		self.text = text

		switch textType {
		case .email:
			keyboardType = .emailAddress
			if #available(iOS 10.0, *) {
				textContentType = .emailAddress
			}
		case .password:
			isSecureTextEntry = true
			if #available(iOS 11.0, *) {
				textContentType = .password
			}

		}

	}

}

// MARK: - Layoutable
extension TextField: Layoutable {

	var preferredPadding: CGFloat {
		return 6
	}

}

// MARK: - Stylable
extension TextField: Stylable {

	func setStyle() {
		textAlignment = .center
		autocapitalizationType = .none
		autocorrectionType = .no
		backgroundColor = Color.darkOrange
		textColor = Color.white
		tintColor = Color.white.withAlphaComponent(0.75)
		layer.cornerRadius = preferredPadding
	}

}
