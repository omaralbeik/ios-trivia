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

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.configure(for: Question.test)
		layoutableView.answersView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationItem.leftBarButtonItem = .init(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancelBarButtonItem))
	}

}

// MARK: - AnswersViewDelegate
extension GameViewController: AnswersViewDelegate {

	func answersView(_ view: AnswersView, sisSelectAnswerAtIndex index: Int) {
		print(index)
	}

}

// MARK: - Actions
private extension GameViewController {

	@objc
	func didTapCancelBarButtonItem() {
		dismiss(animated: true)
	}

}
