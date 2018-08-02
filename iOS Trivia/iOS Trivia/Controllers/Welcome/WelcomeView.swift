//
//  WelcomeView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class WelcomeView: LayoutableView {

	lazy var logoImageView: UIImageView = {
		let view = UIImageView(image: #imageLiteral(resourceName: "welcome_logo"))
		view.tintColor = .red
		return view
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = L10n.Welcome.title
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()

	lazy var startButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle(L10n.Welcome.start, for: .normal)
		return button
	}()

	override var backgroundColor: UIColor? {
		didSet {
			logoImageView.backgroundColor = backgroundColor
			titleLabel.backgroundColor = backgroundColor
			startButton.backgroundColor = backgroundColor
		}
	}

	override func setupViews() {
		super.setupViews()

		addSubview(logoImageView)
		addSubview(titleLabel)
		addSubview(startButton)
	}

	override func setupLayout() {
		logoImageView.snp.makeConstraints { make in
			make.width.height.equalTo(preferredPadding * 13)
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview().offset(-preferredPadding * 3)
		}

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(logoImageView.snp.bottom).offset(preferredPadding)
			make.leading.trailing.equalToSuperview().inset(preferredPadding)
		}

		startButton.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(preferredPadding * 1.5)
			make.leading.trailing.equalToSuperview().inset(preferredPadding)
		}
	}

}
