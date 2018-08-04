//
//  AnswersView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

protocol AnswersViewDelegate: AnyObject {
	func answersView(_ view: AnswersView, didSelectAnswerAtIndex index: Int)
}

final class AnswersView: LayoutableView {

	weak var delegate: AnswersViewDelegate?

	private lazy var stackView: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fill
		view.spacing = preferredPadding / 2
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(stackView)
	}

	override func setupLayout() {
		stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(preferredPadding) }
	}

}

// MARK: - FlipViewDelegate
extension AnswersView: FlipViewDelegate {

	func selectAnswer(atIndex index: Int) {
		let flipViews = stackView.arrangedSubviews.compactMap { $0 as? FlipView }
		flipViews[index].flip(to: .back)
		flipViews[index].confirmButton.sendActions(for: .touchUpInside)
	}

	func flipView(_ view: FlipView, willFlipToFace face: FlipView.Face) {
		let flipViews = stackView.arrangedSubviews.compactMap { $0 as? FlipView }
		for flipView in flipViews where flipView != view {
			flipView.flip(to: .front)
		}
	}

	func flipView(_ view: FlipView, didSelectAnswerAtIndex index: Int) {
		delegate?.answersView(self, didSelectAnswerAtIndex: index)
	}

}

// MARK: - Configure
extension AnswersView {

	func configure(for answers: [Answer]) {
		for view in stackView.arrangedSubviews {
			view.removeFromSuperview()
		}

		for (index, answer) in answers.enumerated() {
			let flipView = FlipView()
			flipView.configure(for: answer, index: index)
			flipView.delegate = self
			stackView.addArrangedSubview(flipView)
		}
	}

}
