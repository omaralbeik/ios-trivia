//
//  Loadingable.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

protocol Loadingable: AnyObject {

	func setLoading(_ loading: Bool)
	var indicatorType: NVActivityIndicatorType { get }
	var indicatorTintColor: UIColor? { get }
	var indicatorBackgroundColor: UIColor? { get }
	var indicatorAlpha: CGFloat { get }
	var indicatorSize: CGSize { get }
	var indicatorPadding: CGFloat { get }
	var indicatorCornerRadius: CGFloat { get }
}

// MARK: - Default implementation for UIView
extension Loadingable where Self: UIView {

	var indicatorType: NVActivityIndicatorType {
		return .ballBeat
	}

	var indicatorTintColor: UIColor? {
		return Color.lightOrange
	}

	var indicatorBackgroundColor: UIColor? {
		return Color.white
	}

	var indicatorAlpha: CGFloat {
		return 0.95
	}

	var indicatorSize: CGSize {
		return CGSize(width: 100, height: 100)
	}

	var indicatorPadding: CGFloat {
		return 25
	}

	var indicatorCornerRadius: CGFloat {
		return 8
	}

	func setLoading(_ loading: Bool) {
		isUserInteractionEnabled = !loading

		if loading {
			if let indicator = subviews.first(where: { $0.tag == 314 }) as? NVActivityIndicatorView {
				indicator.startAnimating()
			} else {
				createIndicator().startAnimating()
			}

		} else {
			if let indicator = subviews.first(where: { $0.tag == 314 }) as? NVActivityIndicatorView {
				indicator.stopAnimating()
				indicator.snp.removeConstraints()
				indicator.removeFromSuperview()
			}
		}

	}

	private func createIndicator() -> NVActivityIndicatorView {
		let indicator = NVActivityIndicatorView(frame: frame, type: indicatorType, color: indicatorTintColor, padding: indicatorPadding)
		indicator.tag = 314
		indicator.backgroundColor = indicatorBackgroundColor
		indicator.alpha = indicatorAlpha
		indicator.layer.cornerRadius = indicatorCornerRadius

		addSubview(indicator)
		indicator.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.equalTo(indicatorSize.width)
			make.height.equalTo(indicatorSize.height)
		}
		return indicator
	}

}
