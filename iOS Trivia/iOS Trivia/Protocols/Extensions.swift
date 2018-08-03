//
//  Extensions.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

extension UINavigationBar {

	/// Set navigationBar background and text colors
	///
	/// - Parameters:
	///   - background: backgound color
	///   - text: text color
	func setColors(background: UIColor, text: UIColor) {
		isTranslucent = false
		backgroundColor = background
		barTintColor = background
		setBackgroundImage(UIImage(), for: .default)
		shadowImage = UIImage()
		tintColor = text
		titleTextAttributes = [.foregroundColor: text]
	}

}

public extension UINavigationItem {

	/// Replace title label with an image in navigation item.
	///
	/// - Parameter image: UIImage to replace title with.
	public func replaceTitle(with image: UIImage) {
		let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
		logoImageView.contentMode = .scaleAspectFit
		logoImageView.image = image
		titleView = logoImageView
	}

}

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

public extension Int {

	/// Random integer in a closed interval range.
	///
	/// - Parameter range: closed interval range.
	/// - Returns: random double in the given closed range.
	public static func random(inRange range: ClosedRange<Int>) -> Int {
		let delta = UInt32(range.upperBound - range.lowerBound + 1)
		return range.lowerBound + Int(arc4random_uniform(delta))
	}

}

internal extension String {

	internal var utf8Encoded: Data {
		return data(using: .utf8)!
	}

}
