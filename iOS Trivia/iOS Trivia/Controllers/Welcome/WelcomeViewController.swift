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
		layoutableView.scoreboardButton.addTarget(self, action: #selector(didTapScoreboardButton(_:)), for: .touchUpInside)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.navigationBar.setColors(background: Color.lightOrange, text: Color.white)
		navigationItem.leftBarButtonItem = .init(image: #imageLiteral(resourceName: "nav_icon_logout"), style: .plain, target: self, action: #selector(didTapLogoutBarButtonItem))
	}

}

// MARK: - Actions
private extension WelcomeViewController {

	@objc
	func didTapLogoutBarButtonItem() {
		AuthCache.drop()
		(UIApplication.shared.delegate as! AppDelegate).showAuthViewController()
	}

	@objc
	func didTapStartButton(_ button: Button) {
		fetchIdToken(sender: button)
	}

	@objc
	func didTapScoreboardButton(_ button: Button) {
		let viewController = UINavigationController(rootViewController: ScoreboardViewController())
		present(viewController, animated: true)
	}

}

// MARK: - Helpers
private extension WelcomeViewController {

	func showGameViewController() {
		let gameViewController = GameViewController()
		let navController = UINavigationController(rootViewController: gameViewController)
		present(navController, animated: true)
	}

}

// MARK: - Networking
private extension WelcomeViewController {

	func clearUserPoints(sender: Loadingable) {
		guard let userId = AuthCache.userId, let token = AuthCache.idToken else {
			(UIApplication.shared.delegate as! AppDelegate).showAuthViewController()
			return
		}

		sender.setLoading(true)
		API.userProvider.request(UserService.clearPoints(userId: userId, token: token)) { [unowned self] result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case.success:
				self.showGameViewController()
			}

		}
	}

	func fetchIdToken(sender: Loadingable) {
		guard let refreshToken = AuthCache.refreshToken else {
			(UIApplication.shared.delegate as! AppDelegate).showAuthViewController()
			return
		}

		if AuthCache.isAuthenticated {
			clearUserPoints(sender: sender)
			return
		}

		sender.setLoading(true)
		API.authProvider.request(.getIdToken(refreshToken: refreshToken), dataType: TokenResult.self) { result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success(let tokenResult):
				AuthCache.saveTokenResult(tokenResult)
				self.clearUserPoints(sender: sender)
			}
		}
	}

}
