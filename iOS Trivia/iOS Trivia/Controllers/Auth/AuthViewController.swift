//
//  AuthViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class AuthViewController: LayoutingViewController, Layouting {
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

		registerForKeyboardEvents()

		layoutableView.modeSegmentedControl.addTarget(self, action: #selector(didChangeModeSegmentedControlIndex(_:)), for: .valueChanged)
		layoutableView.actionButton.addTarget(self, action: #selector(didTapActionButton(_:)), for: .touchUpInside)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		layoutableView.emailTextField.becomeFirstResponder()
	}

	override func setGestureRecognizers() {
		let tap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
		view.addGestureRecognizer(tap)
	}

}

// MARK: - KeyboardObserving
extension AuthViewController: KeyboardObserving {

	func keyboardWillShow(_ notification: KeyboardNotification?) {
		layoutableView.keyboardWillShow(notification)
	}

	func keyboardWillHide(_ notification: KeyboardNotification?) {
		layoutableView.keyboardWillHide(notification)
	}

	func keyboardDidShow(_ notification: KeyboardNotification?) {}
	func keyboardDidHide(_ notification: KeyboardNotification?) {}
	func keyboardWillChangeFrame(_ notification: KeyboardNotification?) {}
	func keyboardDidChangeFrame(_ notification: KeyboardNotification?) {}

}

// MARK: - Actions
private extension AuthViewController {

	@objc
	func didChangeModeSegmentedControlIndex(_ control: UISegmentedControl) {
		mode = Mode(rawValue: control.selectedSegmentIndex)!
	}

	@objc
	func didTapActionButton(_ button: Button) {
		let (message, textField) = layoutableView.isValid
		if let errorMessage = message {
			Alert(body: errorMessage, layout: .statusLine, theme: .error).show()
			textField?.becomeFirstResponder()
			return
		}

		let email = layoutableView.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
		let password = layoutableView.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

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

	func login(sender: Button, email: String, password: String) {
		sender.setLoading(true)

		API.authProvider.request(.login(email: email, password: password), dataType: AuthResult.self) { [unowned self] result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success(let authResult):
				self.saveUserData(sender: sender, authResult: authResult)
			}
		}
	}

	func register(sender: Button, email: String, password: String) {
		sender.setLoading(true)

		API.authProvider.request(.register(email: email, password: password), dataType: AuthResult.self) { [unowned self] result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success(let authResult):
				self.saveUserData(sender: sender, authResult: authResult)
			}
		}
	}

	func saveUserData(sender: Button, authResult: AuthResult) {
		AuthCache.saveAuthResult(authResult)
		sender.setLoading(true)

		API.userProvider.request(.saveInfo(authResult: authResult), dataType: [String: String].self) { result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success:
				(UIApplication.shared.delegate as! AppDelegate).showWelcomeViewController()
			}
		}
	}

}
