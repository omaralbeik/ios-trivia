//
//  QuestionView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class QuestionView: LayoutableView {

	lazy var textLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.font = .systemFont(ofSize: 25, weight: .regular)
		return label
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(textLabel)
	}

	override func setupLayout() {
		textLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(preferredPadding * 2)
			make.leading.bottom.trailing.equalToSuperview().inset(preferredPadding)
		}
	}

}

// MARK: - Configure
extension QuestionView {

	func configure(for question: Question) {
		textLabel.text = question.text
	}

}
