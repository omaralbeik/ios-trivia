//
//  ConfettiView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/4/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import QuartzCore

/// ConfettiView.
final class ConfettiView: LayoutableView {

	/// Confetti emitter.
	var emitter = CAEmitterLayer()

	/// Default confetti colors
	var colors: [UIColor] = [
		UIColor(red: 0.95, green: 0.40, blue: 0.27, alpha: 1.0),
		UIColor(red: 1.00, green: 0.78, blue: 0.36, alpha: 1.0),
		UIColor(red: 0.48, green: 0.78, blue: 0.64, alpha: 1.0),
		UIColor(red: 0.30, green: 0.76, blue: 0.85, alpha: 1.0),
		UIColor(red: 0.58, green: 0.39, blue: 0.55, alpha: 1.0)
	]

	/// Confetti intensity _(default is 0.5)_.
	var intensity: Float = 0.5

	/// Set this to start or stop confetti.
	var isActive: Bool = false {
		didSet {
			emitter.birthRate = isActive ? (intensity * 6) : 0
		}
	}

	/// Create a new confetti view and set its properties.
	///
	/// - Parameters:
	///   - colors: confetti colors array.
	///   - intensity: confetti emitter intensity _(default is 0.5)_.
	convenience init(colors: [UIColor] = [], intensity: Float = 0.5) {
		self.init()

		if !colors.isEmpty {
			self.colors = colors
		}

		self.intensity = intensity
	}

	/// Setup view and its subviews here.
	override func setupViews() {
		isUserInteractionEnabled = false

		emitter.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
		emitter.emitterShape = kCAEmitterLayerLine
		emitter.emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)

		emitter.emitterCells = colors.map { self.confetti(forColor: $0) }
		layer.addSublayer(emitter)
		emitter.birthRate = 0
	}

	/// The bounds rectangle, which describes the view’s location and size in its own coordinate system.
	override var bounds: CGRect {
		didSet {
			setupViews()
		}
	}

	/// Returns a confetti with a given color.
	///
	/// - Parameter color: color.
	/// - Returns: CAEmitterCell for color.
	internal func confetti(forColor color: UIColor) -> CAEmitterCell {
		let cell = CAEmitterCell()
		cell.birthRate = intensity * 6
		cell.lifetime = intensity * 12
		cell.color = color.cgColor
		cell.velocity = CGFloat(intensity * 350)
		cell.velocityRange = CGFloat(intensity * 80)
		cell.emissionLongitude = .pi
		cell.emissionRange = .pi/4
		cell.spin = CGFloat(intensity * 3.5)
		cell.spinRange = CGFloat(intensity * 4)
		cell.scaleRange = CGFloat(intensity)
		cell.scaleSpeed = CGFloat(intensity * -0.1)
		cell.contents = #imageLiteral(resourceName: "confetti").cgImage

		return cell
	}

}
