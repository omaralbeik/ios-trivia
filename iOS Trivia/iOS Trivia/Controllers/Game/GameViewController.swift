//
//  GameViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class GameViewController: LayoutingViewController, Layouting {
	typealias ViewType = GameView

	var numberOfQuestions = 10
	var remainingIds: [Int] = []
	var currentQuestion: Question?

	var usedWildCards = 0
	var allowedWildCards = 3

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		remainingIds = generateRandomQuestionIds()
		layoutableView.answersView.delegate = self
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		fetchNextQuestion(sender: layoutableView)
	}

	override func setNavigationItem() {
		navigationController?.navigationBar.setColors(background: Color.lightOrange, text: Color.white)
		navigationItem.replaceTitle(with: #imageLiteral(resourceName: "nav_logo"))
		navigationItem.leftBarButtonItem = .init(image: #imageLiteral(resourceName: "nav_icon_close"), style: .plain, target: self, action: #selector(didTapCancelBarButtonItem))
	}

}

// MARK: - AnswersViewDelegate
extension GameViewController: AnswersViewDelegate {

	func answersView(_ view: AnswersView, sisSelectAnswerAtIndex index: Int) {
		guard let question = currentQuestion else { return }
		submitAnswer(sender: layoutableView, index: index, in: question)
	}

}

// MARK: - Actions
private extension GameViewController {

	@objc
	func didTapCancelBarButtonItem() {
		guard !remainingIds.isEmpty else {
			dismiss(animated: true)
			return
		}

		let alert = UIAlertController(title: L10n.Game.QuitAlert.title, message: nil, preferredStyle: .alert)

		let quitAction = UIAlertAction(title: L10n.Game.QuitAlert.Options.quit, style: .destructive) { [unowned self] _ in
			self.dismiss(animated: true)
		}

		let stayAction = UIAlertAction(title: L10n.Game.QuitAlert.Options.stay, style: .cancel, handler: nil)

		alert.addAction(quitAction)
		alert.addAction(stayAction)

		alert.view.tintColor = Color.darkBlack
		present(alert, animated: true)
	}

}

// MARK: - Networking
private extension GameViewController {

	func submitAnswer(sender: Loadingable, index: Int, in question: Question) {
		guard let userId = AuthCache.userId else { return }
		guard let token = AuthCache.idToken else { return }

		let points = question.answers[index].isCorrect ? question.points : 0

		sender.setLoading(true)
		API.userProvider.request(.submitAnswer(questionId: question.id, score: points, userId: userId, token: token), dataType: [String: Int].self) { [unowned self] result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success:
				self.fetchNextQuestion(sender: sender)
			}
		}
	}

	func fetchNextQuestion(sender: Loadingable) {
		guard let id = remainingIds.popLast() else {
			print("Game ended")
			return
		}

		sender.setLoading(true)
		API.gameProvider.request(.question(id: id), dataType: Question.self) { [unowned self] result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success(let question):
				self.updateView(question: question)
			}
		}
	}

	func updateView(question: Question) {
		currentQuestion = question
		layoutableView.configure(for: question)
		let answeredCount = numberOfQuestions - remainingIds.count
		layoutableView.configureHeader(question: answeredCount, maxQuestions: numberOfQuestions, wildCard: usedWildCards, maxWildCards: allowedWildCards)
	}

}

// MARK: - Helpers
private extension GameViewController {

	func generateRandomQuestionIds() -> [Int] {
		var ids: [Int] = []
		while ids.count < numberOfQuestions {
			let id = Int.random(inRange: 1...12)
			if !ids.contains(id) {
				ids.append(id)
			}
		}
		return ids
	}

}
