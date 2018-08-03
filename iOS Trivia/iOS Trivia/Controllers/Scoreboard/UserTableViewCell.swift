//
//  UserTableViewCell.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/4/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class UserTableViewCell: LayoutableTableViewCell {

	lazy var rankingLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 20, weight: .bold)
		label.backgroundColor = Color.lightOrange
		label.textColor = Color.white
		return label
	}()

	lazy var emailLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 15, weight: .regular)
		label.textColor = Color.darkBlack
		return label
	}()

	lazy var pointsLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 17, weight: .semibold)
		label.textColor = Color.lightBlack
		return label
	}()

	lazy var labelsStackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [emailLabel, pointsLabel])
		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fill
		view.spacing = preferredPadding / 8
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(rankingLabel)
		addSubview(labelsStackView)
	}

	override func setupLayout() {
		rankingLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.top.bottom.equalToSuperview().inset(1)
			make.width.equalTo(preferredPadding * 3)
		}

		labelsStackView.snp.makeConstraints { make in
			make.leading.equalTo(rankingLabel.snp.trailing).offset(preferredPadding)
			make.trailing.equalToSuperview().inset(preferredPadding)
			make.top.bottom.greaterThanOrEqualToSuperview().inset(preferredPadding / 2)
			make.centerY.equalToSuperview()
		}
	}

}

// MARK: - Configure
extension UserTableViewCell {

	func configure(for user: User, index: Int) {
		rankingLabel.text = "\(index + 1)"
		emailLabel.text = user.email
		pointsLabel.text = L10n.Scoreboard.Cell.totalPoints(user.totalPoints)
	}

}

// MARK: - Reusable
extension UserTableViewCell: Reusable {

	static var reuseIdentifier: String {
		return "UserTableViewCell"
	}

}
