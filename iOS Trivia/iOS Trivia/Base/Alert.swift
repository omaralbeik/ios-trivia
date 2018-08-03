//
//  Alert.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import SwiftMessages

/// Offers a quick way to show user alerts using SwiftMessages
class Alert {

	var title: String?
	var body: String?
	var layout: MessageView.Layout = .statusLine
	var theme: Theme = .warning

	weak private var message: MessageView!
	var config: SwiftMessages.Config!

	init(title: String? = nil, body: String?, layout: MessageView.Layout = MessageView.Layout.cardView, theme: Theme = Theme.warning, allowDismiss: Bool = true) {

		SwiftMessages.pauseBetweenMessages = 0

		self.title = title
		self.body = body

		let message = MessageView.viewFromNib(layout: layout)
		message.configureTheme(theme)
		message.button?.isHidden = true

		if title == nil {
			message.titleLabel?.isHidden = true
		}

		var config = SwiftMessages.Config()
		config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
		config.preferredStatusBarStyle = .lightContent
		config.presentationStyle = .top
		config.dimMode = .none
		config.shouldAutorotate = true
		config.duration = .automatic

		message.titleLabel?.text = title
		message.bodyLabel?.text = body

		if allowDismiss {
			message.tapHandler = { _ in
				SwiftMessages.sharedInstance.hide()
			}
		}

		self.message = message
		self.config = config

	}

	convenience init(serverError: Error) {
		self.init(body: serverError.localizedDescription, theme: .error)
	}

	convenience init(serverError: String) {
		self.init(body: serverError, theme: .error)
	}

	func show() {
		SwiftMessages.hideAll()
		SwiftMessages.show(config: config, view: message)
	}

}
