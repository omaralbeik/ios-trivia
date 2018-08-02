//
//  GameView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class GameView: LayoutableView {

	private lazy var headerView: GameHeaderView = {
		return GameHeaderView()
	}()

	private lazy var scrollView: UIScrollView = {
		let view = UIScrollView()
		view.backgroundColor = .white
		view.showsVerticalScrollIndicator = false
		return view
	}()

	private lazy var questionView: QuestionView = {
		return QuestionView()
	}()

	lazy var answersView: AnswersView = {
		return AnswersView()
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(headerView)

		scrollView.addSubview(questionView)
		scrollView.addSubview(answersView)
		addSubview(scrollView)
	}

	override func setupLayout() {
		headerView.snp.makeConstraints { make in
			make.leading.top.trailing.equalToSuperview()
			make.height.equalTo(preferredPadding * 6)
		}
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(headerView.snp.bottom)
			make.leading.trailing.bottom.equalToSuperview()
		}

		questionView.snp.makeConstraints { make in
			make.top.width.centerX.equalToSuperview()
		}

		answersView.snp.makeConstraints { make in
			make.top.equalTo(questionView.snp.bottom)
			make.width.centerX.bottom.equalToSuperview()
		}
	}

}

// MARK: - Configure
extension GameView {

	func configure(for question: Question) {
		questionView.configure(for: question)
		answersView.configure(for: question.answers)
	}

}
