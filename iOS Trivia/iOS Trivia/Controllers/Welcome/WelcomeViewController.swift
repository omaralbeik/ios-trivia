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
		fetchIdToken()
	}

}

private extension WelcomeViewController {

	func showGameViewController() {
		let gameViewController = GameViewController()
		let navController = UINavigationController(rootViewController: gameViewController)
		present(navController, animated: true)
	}

}

// MARK: - Networking
private extension WelcomeViewController {

	func fetchIdToken() {
		guard let refreshToken = AuthCache.refreshToken else {
			(UIApplication.shared.delegate as! AppDelegate).showAuthViewController()
			return
		}

		if AuthCache.isAuthenticated {
			showGameViewController()
			return
		}

		API.authProvider.request(.getIdToken(refreshToken: refreshToken)) { result in
			switch result {
			case .failure(let error):
				print(error.localizedDescription)
			case .success(let response):
				guard let tokenResult = response.tokenResult else {
					print(try? response.mapJSON())
					return
				}

				AuthCache.saveTokenResult(tokenResult)
				self.showGameViewController()
			}
		}
	}

}
