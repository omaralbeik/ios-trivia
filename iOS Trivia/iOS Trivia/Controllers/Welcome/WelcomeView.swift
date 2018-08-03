//
//  WelcomeView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class WelcomeView: LayoutableView {

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

	lazy var viewOnGithubButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "icon_github"), for: .normal)
		button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: preferredPadding / 2)
		button.setTitle(L10n.Welcome.viewOnGithub, for: .normal)
		button.tintColor = Color.white
		return button
	}()

	override var backgroundColor: UIColor? {
		didSet {
			viewOnGithubButton.backgroundColor = backgroundColor
		}
	}

	override func setupViews() {
		backgroundColor = Color.lightOrange
		addSubview(buttonsStackView)
		addSubview(viewOnGithubButton)
	}

	override func setupLayout() {
		startButton.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2) }
		scoreboardButton.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2) }

		buttonsStackView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.trailing.equalToSuperview().inset(preferredPadding * 1.5)
		}

		viewOnGithubButton.snp.makeConstraints { make in
			make.leading.bottom.trailing.equalToSuperview().inset(preferredPadding * 1.5)
		}
	}

}
