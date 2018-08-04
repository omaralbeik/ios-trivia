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
		label.font = .systemFont(ofSize: 22, weight: .regular)
		return label
	}()

	override var backgroundColor: UIColor? {
		didSet {
			textLabel.backgroundColor = backgroundColor
		}
	}

	override func setupViews() {
		super.setupViews()

		addSubview(textLabel)
	}

	override func setupLayout() {
		textLabel.snp.makeConstraints { make in
			make.leading.top.trailing.equalToSuperview().inset(preferredPadding)
			make.bottom.equalToSuperview()
		}
	}

}

// MARK: - Configure
extension QuestionView {

	func configure(for question: Question) {
		textLabel.text = question.text
	}

}
