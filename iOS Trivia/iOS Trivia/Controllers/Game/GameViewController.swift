//
//  GameViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class GameViewController: LayoutingViewController, Layouting, Confettiable {
	typealias ViewType = GameView

	weak var timer: Timer?
	var remainingTime: TimeInterval = 0 {
		didSet {
			layoutableView.timerView.configure(reminingTime: remainingTime, maxTime: currentQuestion.duration)
		}
	}

	let numberOfQuestions = 10
	var remainingIds: [Int] = []
	var currentQuestion: Question! {
		didSet {
			remainingTime = currentQuestion.duration
		}
	}

	var usedWildCards = 0 {
		didSet {
			layoutableView.useWildCardButton.isEnabled = (usedWildCards < numberOfWildCards)
		}
	}
	let numberOfWildCards = 3

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		remainingIds = generateRandomQuestionIds()
		layoutableView.answersView.delegate = self

		layoutableView.useWildCardButton.addTarget(self, action: #selector(didTapUseWildCardButton), for: .touchUpInside)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		fetchNextQuestion(sender: layoutableView)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		timer?.invalidate()
	}

	override func setNavigationItem() {
		navigationController?.navigationBar.setColors(background: Color.lightOrange, text: Color.white)
		navigationItem.replaceTitle(with: #imageLiteral(resourceName: "nav_logo"))
		navigationItem.leftBarButtonItem = .init(image: #imageLiteral(resourceName: "nav_icon_close"), style: .plain, target: self, action: #selector(didTapCancelBarButtonItem))
	}
}

// MARK: - AnswersViewDelegate
extension GameViewController: AnswersViewDelegate {

	func answersView(_ view: AnswersView, didSelectAnswerAtIndex index: Int) {
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

	@objc
	func didTapUseWildCardButton() {
		guard let correctAnswerIndex = currentQuestion.answers.index(where: { $0.isCorrect }) else { return }
		layoutableView.answersView.selectAnswer(atIndex: correctAnswerIndex)
		usedWildCards += 1
	}

}

// MARK: - Timer Helpers
private extension GameViewController {

	func scheduledQuestionTimer() {
		timer?.invalidate()
		timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(updateTime(_:)), userInfo: nil, repeats: true)
	}

	@objc
	func updateTime(_ timer: Timer) {
		guard remainingTime > 0 else {
			timer.invalidate()
			fetchNextQuestion(sender: layoutableView)
			return
		}

		remainingTime -= 0.001
	}

}

// MARK: - Networking
private extension GameViewController {

	func submitAnswer(sender: Loadingable, index: Int, in question: Question) {
		guard let userId = AuthCache.userId else { return }
		guard let token = AuthCache.idToken else { return }

		let points = question.answers[index].isCorrect ? question.points : 0

		timer?.invalidate()
		sender.setLoading(true)
		API.userProvider.request(.submitAnswer(questionId: question.id, score: points, userId: userId, token: token), dataType: [String: Int].self) { [unowned self] result in
			self.scheduledQuestionTimer()
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success:

				if question.answers[index].isCorrect {
					self.showRightAnswerAlert(points: question.points)
				} else {
					self.showWrongAnswerAlert()
				}

				self.fetchNextQuestion(sender: sender)
			}
		}
	}

	func fetchNextQuestion(sender: Loadingable) {
		guard let id = remainingIds.popLast() else {
			let parent = presentingViewController
			dismiss(animated: true) {
				parent?.present(UINavigationController(rootViewController: ScoreboardViewController()), animated: true)
			}

			return
		}

		timer?.invalidate()
		sender.setLoading(true)
		API.gameProvider.request(.question(id: id), dataType: Question.self) { [unowned self] result in
			self.scheduledQuestionTimer()
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				self.dismiss(animated: true)
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
		let wildCardsCount = numberOfWildCards - usedWildCards
		layoutableView.configureHeader(question: answeredCount, maxQuestions: numberOfQuestions, wildCard: wildCardsCount, maxWildCards: numberOfWildCards)
		scheduledQuestionTimer()
		layoutableView.useWildCardButton.isHidden = false
	}

}

// MARK: - Helpers
private extension GameViewController {

	func showRightAnswerAlert(points: Int) {
		Alert(body: L10n.Game.Messages.rightAnswer(points), layout: .statusLine, theme: .success).show()
		showConfetti()
	}

	func showWrongAnswerAlert() {
		Alert(body: L10n.Game.Messages.wrongAnswer, layout: .statusLine, theme: .error).show()
	}

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
