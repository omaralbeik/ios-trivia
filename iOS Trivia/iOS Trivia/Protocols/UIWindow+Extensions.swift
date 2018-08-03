//
//  UIWindow+Extensions.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

extension UIWindow {

	/// Switch current root view controller with a new view controller.
	///
	/// - Parameters:
	///   - viewController: new view controller.
	///   - animated: set to true to animate view controller change _(default is true)_.
	///   - duration: animation duration in seconds _(default is 0.5)_.
	///   - options: animataion options _(default is .transitionFlipFromRight)_.
	///   - completion: optional completion handler called when view controller is changed.
	func switchRootViewController(
		to viewController: UIViewController,
		animated: Bool = true,
		duration: TimeInterval = 0.5,
		options: UIViewAnimationOptions = .transitionFlipFromRight,
		_ completion: (() -> Void)? = nil) {

		guard animated else {
			rootViewController = viewController
			return
		}

		UIView.transition(with: self, duration: duration, options: options, animations: {
			let oldState = UIView.areAnimationsEnabled
			UIView.setAnimationsEnabled(false)
			self.rootViewController = viewController
			UIView.setAnimationsEnabled(oldState)
		}, completion: { _ in
			completion?()
		})
	}

}
