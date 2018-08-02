//
//  WelcomeViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class WelcomeViewController: UIViewController, Layouting {
	typealias ViewType = WelcomeView

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.startButton.addTarget(self, action: #selector(didTapStartButton(_:)), for: .touchUpInside)
	}

}

// MARK: - Actions
private extension WelcomeViewController {

	@objc
	func didTapStartButton( _ button: UIButton) {
		let gameViewController = GameViewController()
		let navController = UINavigationController(rootViewController: gameViewController)
		present(navController, animated: true)
	}

}
