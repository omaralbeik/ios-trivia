//
//  Confettiable.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/4/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

/// Conform to Confettiable protocol to show confetti in a view controller or a view.
protocol Confettiable: AnyObject {

	/// Show confetti.
	///
	/// - Parameters:
	///   - duration: confetti duration in seconds.
	///   - delay: confetti delay in seconds.
	func showConfetti(duration: TimeInterval, delay: TimeInterval)

}

// MARK: - Default implementation for UIViewController.
extension Confettiable where Self: UIViewController {

	/// Show confetti.
	///
	/// - Parameters:
	///   - duration: confetti duration in seconds _(default is 0.25)_.
	///   - delay: confetti delay in seconds _(default is 0.0)_.
	func showConfetti(duration: TimeInterval = 0.25, delay: TimeInterval = 0) {
		let confettiView = ConfettiView(frame: view.bounds)
		confettiView.layer.zPosition = 100

		DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
			self.view.addSubview(confettiView)
			confettiView.isActive = true
		}

		let totalDelay = delay + duration
		DispatchQueue.main.asyncAfter(deadline: .now() + totalDelay) {
			confettiView.isActive = false

			DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
				confettiView.removeFromSuperview()
			}
		}

	}
}

// MARK: - Default implementation for UIView.
extension Confettiable where Self: UIView {

	/// Show confetti.
	///
	/// - Parameters:
	///   - duration: confetti duration in seconds _(default is 0.25)_.
	///   - delay: confetti delay in seconds _(default is 0.0)_.
	func showConfetti(duration: TimeInterval = 0.25, delay: TimeInterval = 0) {
		let confettiView = ConfettiView(frame: bounds)
		confettiView.layer.zPosition = 100

		DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
			self.addSubview(confettiView)
			confettiView.isActive = true
		}

		let totalDelay = delay + duration
		DispatchQueue.main.asyncAfter(deadline: .now() + totalDelay) {
			confettiView.isActive = false

			DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
				confettiView.removeFromSuperview()
			}
		}

	}
}
