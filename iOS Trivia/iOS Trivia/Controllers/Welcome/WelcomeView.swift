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
		let view = UIImageView(image: #imageLiteral(resourceName: "logo"))
		view.tintColor = .white
		return view
	}()

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = L10n.Welcome.title
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()

	lazy var startButton: Button = {
		return Button(title: L10n.Welcome.startGame)
	}()

	lazy var scoreboardButton: Button = {
		return Button(title: L10n.Welcome.scoreboard)
	}()

	lazy var buttonsStackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [startButton, scoreboardButton])
		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fillEqually
		view.spacing = preferredPadding / 2
		return view
	}()

	override var backgroundColor: UIColor? {
		didSet {
			logoImageView.backgroundColor = backgroundColor
			titleLabel.backgroundColor = backgroundColor
		}
	}

	override func setupViews() {
		backgroundColor = Color.lightOrange

		addSubview(logoImageView)
		addSubview(titleLabel)
		addSubview(buttonsStackView)
	}

	override func setupLayout() {
		logoImageView.snp.makeConstraints { make in
			make.width.equalTo(preferredPadding * 13)
			make.centerX.equalToSuperview()
			make.centerY.equalToSuperview().offset(-preferredPadding * 4)
		}

		titleLabel.snp.makeConstraints { make in
			make.top.equalTo(logoImageView.snp.bottom).offset(preferredPadding)
			make.leading.trailing.equalToSuperview().inset(preferredPadding)
		}

		startButton.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2) }
		scoreboardButton.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2) }

		buttonsStackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(preferredPadding * 2)
			make.leading.trailing.equalToSuperview().inset(preferredPadding * 1.5)
		}
	}

}
