//
//  GameHeaderView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class GameHeaderView: LayoutableView {

	private lazy var questionTitleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .light)
		label.text = L10n.Game.Header.Titles.currentQuestion
		label.textAlignment = .center
		return label
	}()

	private lazy var wildCardTitleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .light)
		label.text = L10n.Game.Header.Titles.availableWildCards
		label.textAlignment = .center
		return label
	}()

	private lazy var titleLabelsStackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [questionTitleLabel, wildCardTitleLabel])
		view.axis = .horizontal
		view.alignment = .fill
		view.distribution = .fillEqually
		return view
	}()

	lazy var questionLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 30, weight: .bold)
		label.text = " "
		label.textAlignment = .center
		return label
	}()

	lazy var wildCardLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 30, weight: .bold)
		label.text = " "
		label.textAlignment = .center
		return label
	}()

	private lazy var labelsStackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [questionLabel, wildCardLabel])
		view.axis = .horizontal
		view.alignment = .fill
		view.distribution = .fillEqually
		return view
	}()

	override var backgroundColor: UIColor? {
		didSet {
			questionTitleLabel.backgroundColor = backgroundColor
			wildCardTitleLabel.backgroundColor = backgroundColor
			questionLabel.backgroundColor = backgroundColor
			wildCardLabel.backgroundColor = backgroundColor
		}
	}

	override var tintColor: UIColor! {
		didSet {
			questionTitleLabel.textColor = tintColor
			wildCardTitleLabel.textColor = tintColor
			questionLabel.textColor = tintColor
			wildCardLabel.textColor = tintColor

		}
	}

	override func setupViews() {
		backgroundColor = Color.lightOrange
		tintColor = Color.white

		addSubview(titleLabelsStackView)
		addSubview(labelsStackView)
	}

	override func setupLayout() {
		titleLabelsStackView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(preferredPadding)
			make.leading.trailing.equalToSuperview()
		}

		labelsStackView.snp.makeConstraints { make in
			make.top.equalTo(titleLabelsStackView.snp.bottom)
			make.leading.trailing.equalToSuperview()
			make.bottom.equalToSuperview().inset(preferredPadding)
		}
	}

}
