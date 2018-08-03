//
//  FlipView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

protocol FlipViewDelegate: AnyObject {
	func flipView(_ view: FlipView, willFlipToFace face: FlipView.Face)
	func flipView(_ view: FlipView, didFlipToFace face: FlipView.Face)
	func flipView(_ view: FlipView, didSelectAnswerAtIndex index: Int)
}

extension FlipViewDelegate {
	func flipView(_ view: FlipView, willFlipToFace face: FlipView.Face) {}
	func flipView(_ view: FlipView, didFlipToFace face: FlipView.Face) {}
	func flipView(_ view: FlipView, didSelectAnswerAtIndex index: Int) {}
}

final class FlipView: LayoutableView {

	enum Face {
		case front
		case back
	}

	var currentFace: Face = .front

	weak var delegate: FlipViewDelegate?

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.textAlignment = .center
		label.numberOfLines = 0
		label.font = .systemFont(ofSize: 20, weight: .regular)
		return label
	}()

	lazy var confirmButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle(L10n.Game.Answer.select, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
		button.tintColor = Color.white
		button.backgroundColor = Color.clear
		button.isHidden = true
		button.addTarget(self, action: #selector(didTapSelectButton), for: .touchUpInside)
		return button
	}()

	override func setupViews() {
		backgroundColor = Color.softGray

		layer.cornerRadius = 8
		addSubview(titleLabel)
		addSubview(confirmButton)

		let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
		addGestureRecognizer(tap)
	}

	override func setupLayout() {
		titleLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		confirmButton.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(preferredPadding / 2)
			make.leading.trailing.equalToSuperview().inset(preferredPadding * 2)
		}
	}

}

// MARK: - Helpers
extension FlipView {

	func flip(to face: Face) {
		guard  currentFace != face else { return }

		delegate?.flipView(self, willFlipToFace: face)
		self.currentFace = face
		isUserInteractionEnabled = false

		let options: UIViewAnimationOptions = (face == .front) ? .transitionFlipFromBottom : .transitionFlipFromTop
		UIView.transition(with: self, duration: 0.5, options: options, animations: { [unowned self] in
			self.titleLabel.isHidden = (face == .back)
			self.confirmButton.isHidden = (face == .front)
			self.backgroundColor = (face == .front) ? Color.softGray : Color.softYellow
			}, completion: { [unowned self] _ in
				self.isUserInteractionEnabled = true
				self.delegate?.flipView(self, didFlipToFace: face)
		})
	}

}

// MARK: - Actions
private extension FlipView {

	@objc
	func didTap() {
		switch currentFace {
		case .front:
			flip(to: .back)
		case .back:
			flip(to: .front)
		}
	}

	@objc
	func didTapSelectButton() {
		delegate?.flipView(self, didSelectAnswerAtIndex: tag)
	}

}

// MARK: - Configure
extension FlipView {

	func configure(for answer: Answer, index: Int) {
		titleLabel.text = answer.text
		tag = index
	}

}
