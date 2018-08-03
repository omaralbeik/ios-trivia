//
//  GameViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController, Layouting {
	typealias ViewType = GameView

	var currentQuestionId = 1
	var allowedQuestions = 12
	var currentQuestion: Question?

	var usedWildCards = 0
	var allowedWildCards = 3

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.answersView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelBarButtonItem))
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		fetchNextQuestion()
	}

}

// MARK: - AnswersViewDelegate
extension GameViewController: AnswersViewDelegate {

	func answersView(_ view: AnswersView, sisSelectAnswerAtIndex index: Int) {
		guard let question = currentQuestion else { return }
		print(question.answers[index].isCorrect)
		fetchNextQuestion()
	}

}

// MARK: - Actions
private extension GameViewController {

	@objc
	func didTapCancelBarButtonItem() {
		dismiss(animated: true)
	}

}

// MARK: - Networking
private extension GameViewController {

	func fetchNextQuestion() {
		guard currentQuestionId < allowedQuestions else {
			print("Game ended")
			return
		}
		guard let token = AuthCache.idToken else {
			dismiss(animated: true)
			return
		}
		API.gameProvider.request(GameService.question(id: currentQuestionId, token: token)) { [unowned self] result in
			switch result {
			case .failure(let error):
				print(error.localizedDescription)
			case .success(let response):
				guard let question = response.question else {
					print("Server Error")
					return
				}

				self.updateView(question: question)
			}
		}
	}

	func updateView(question: Question) {
		currentQuestion = question
		layoutableView.configure(for: question)
		layoutableView.configureHeader(question: currentQuestionId, maxQuestions: allowedQuestions, wildCard: usedWildCards, maxWildCards: allowedWildCards)
		currentQuestionId += 1
	}

}
