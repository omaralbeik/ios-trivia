//
//  TimerView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/4/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class TimerView: LayoutableView {

	private lazy var progressView: UIProgressView = {
		let view = UIProgressView()
		view.trackTintColor = Color.clear
		return view
	}()

	private lazy var remainingTimeLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		label.textAlignment = .right
		label.text = " "
		return label
	}()

	override var backgroundColor: UIColor? {
		didSet {
			progressView.backgroundColor = backgroundColor
			remainingTimeLabel.backgroundColor = backgroundColor
		}
	}

	override var tintColor: UIColor! {
		didSet {
			progressView.tintColor = tintColor
			progressView.progressTintColor = tintColor
			remainingTimeLabel.textColor = tintColor
		}
	}

	override func setupViews() {
		backgroundColor = Color.lightOrange
		tintColor = Color.white

		addSubview(progressView)
		addSubview(remainingTimeLabel)
	}

	override func setupLayout() {
		remainingTimeLabel.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.bottom.trailing.equalToSuperview().inset(preferredPadding * 0.2)
			make.width.equalTo(preferredPadding * 3)
		}

		progressView.snp.makeConstraints { make in
			make.height.equalTo(preferredPadding / 5)
			make.leading.bottom.equalToSuperview()
			make.trailing.equalTo(remainingTimeLabel.snp.leading)
		}
	}

}

// MARK: - Configure
extension TimerView {

	func configure(reminingTime: TimeInterval, maxTime: TimeInterval) {
		remainingTimeLabel.text = reminingTime.timeString()
		progressView.progress = Float(reminingTime / maxTime)
	}

}
