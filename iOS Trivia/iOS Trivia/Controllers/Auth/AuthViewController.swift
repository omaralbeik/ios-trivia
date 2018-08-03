//
//  AuthViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class AuthViewController: UIViewController, Layouting {
	typealias ViewType = AuthView

	enum Mode: Int {
		case login = 0
		case register = 1
	}

	var mode: Mode = .login {
		didSet {
			layoutableView.configure(for: mode)
		}
	}

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.modeSegmentedControl.addTarget(self, action: #selector(didChangeModeSegmentedControlIndex(_:)), for: .valueChanged)
		layoutableView.actionButton.addTarget(self, action: #selector(didTapActionButton(_:)), for: .touchUpInside)

		//FIXME: remove test user
		layoutableView.emailTextField.text = "omaralbeik@gmail.com"
		layoutableView.passwordTextField.text = "testpass"
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		layoutableView.emailTextField.becomeFirstResponder()
	}

}

// MARK: - Actions
private extension AuthViewController {

	@objc
	func didChangeModeSegmentedControlIndex(_ control: UISegmentedControl) {
		mode = Mode(rawValue: control.selectedSegmentIndex)!
	}

	@objc
	func didTapActionButton(_ button: UIButton) {
		guard let email = layoutableView.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
			return
		}
		guard let password = layoutableView.passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
			return
		}

		switch mode {
		case .login:
			login(sender: button, email: email, password: password)
		case .register:
			register(sender: button, email: email, password: password)
		}
	}

}

// MARK: - Networking
private extension AuthViewController {

	func login(sender: UIButton, email: String, password: String) {
		sender.isEnabled = false

		API.authProvider.request(.login(email: email, password: password)) { result in
			sender.isEnabled = true
			switch result {
			case .failure(let error):
				print(error.localizedDescription)
			case .success(let response):
				guard let authResult = response.authResult else {
//					print(try? response.mapJSON())
					return
				}

				AuthCache.saveAuthResult(authResult)
				(UIApplication.shared.delegate as! AppDelegate).showWelcomeViewController()
			}
		}
	}

	func register(sender: UIButton, email: String, password: String) {
		sender.isEnabled = false

		API.authProvider.request(.register(email: email, password: password)) { result in
			sender.isEnabled = true
			switch result {
			case .failure(let error):
				print(error.localizedDescription)
			case .success(let response):
				guard let authResult = response.authResult else { return }

				AuthCache.saveAuthResult(authResult)
				(UIApplication.shared.delegate as! AppDelegate).showWelcomeViewController()
			}
		}
	}

}
