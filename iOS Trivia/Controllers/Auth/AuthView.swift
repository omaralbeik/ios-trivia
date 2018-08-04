//
//  AuthView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class AuthView: LayoutableView {

	lazy var logoImageView: UIImageView = {
		let view = UIImageView(image: #imageLiteral(resourceName: "logo"))
		view.contentMode = .scaleAspectFit
		view.tintColor = Color.white
		return view
	}()

	lazy var modeSegmentedControl: UISegmentedControl = {
		let control = UISegmentedControl(items: [L10n.Auth.Mode.login, L10n.Auth.Mode.register])
		control.selectedSegmentIndex = 0
		control.tintColor = Color.white
		return control
	}()

	lazy var emailTextField: TextField = {
		return TextField(placeholder: L10n.Auth.emailAddress, textType: .email)
	}()

	lazy var passwordTextField: UITextField = {
		return TextField(placeholder: L10n.Auth.password, textType: .password)
	}()

	lazy var actionButton: Button = {
		return Button(title: L10n.Auth.Action.login)
	}()

	lazy var stackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fillEqually
		view.spacing = preferredPadding / 2
		return view
	}()

	override var backgroundColor: UIColor? {
		didSet {
			logoImageView.backgroundColor = backgroundColor
		}
	}

	override func setupViews() {
		backgroundColor = Color.lightOrange

		addSubview(logoImageView)
		addSubview(modeSegmentedControl)
		addSubview(stackView)
		addSubview(actionButton)
	}

	override func setupLayout() {
		logoImageView.snp.makeConstraints { make in
			make.width.lessThanOrEqualToSuperview().multipliedBy(0.75)
			make.centerX.equalToSuperview()
			make.top.greaterThanOrEqualToSuperview().inset(preferredPadding * 1.5)
		}

		modeSegmentedControl.snp.makeConstraints { make in
			make.top.equalTo(logoImageView.snp.bottom).offset(preferredPadding)
			make.leading.trailing.equalToSuperview().inset(preferredPadding)
			make.height.equalTo(preferredPadding * 2)
		}

		emailTextField.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2.2) }
		passwordTextField.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2.2) }

		stackView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(preferredPadding)
			make.top.equalTo(modeSegmentedControl.snp.bottom).offset(preferredPadding)
		}

		actionButton.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(preferredPadding)
			make.leading.trailing.equalTo(stackView)
			make.height.equalTo(preferredPadding * 2.2)
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().inset(preferredPadding * 2)
		}
	}
}

// MARK: - KeyboardHandling
extension AuthView: KeyboardHandling {

	func keyboardWillShow(_ notification: KeyboardNotification?) {
		let height = notification?.endFrame.height ?? 250
		let duration = notification?.animationDuration ?? 0.25
		actionButton.snp.updateConstraints { $0.bottom.equalToSuperview().inset(height + (preferredPadding * 2)) }
		UIView.animate(withDuration: duration) { [weak self] in
			self?.layoutIfNeeded()
		}
	}

	func keyboardWillHide(_ notification: KeyboardNotification?) {
		let duration = notification?.animationDuration ?? 0.25
		actionButton.snp.updateConstraints { $0.bottom.equalToSuperview().inset(preferredPadding * 2) }
		UIView.animate(withDuration: duration) { [weak self] in
			self?.layoutIfNeeded()
		}
	}

	func keyboardDidShow(_ notification: KeyboardNotification?) {}
	func keyboardDidHide(_ notification: KeyboardNotification?) {}
	func keyboardWillChangeFrame(_ notification: KeyboardNotification?) {}
	func keyboardDidChangeFrame(_ notification: KeyboardNotification?) {}

}

// MARK: - Configure
extension AuthView {

	func configure(for mode: AuthViewController.Mode) {
		var title: String {
			switch mode {
			case .login:
				return L10n.Auth.Action.login
			case .register:
				return L10n.Auth.Action.register
			}
		}
		actionButton.setTitle(title, for: .normal)
	}

}

// MARK: - Validation
extension AuthView {

	/// Check if form is valid.
	var isValid: (message: String?, field: UITextField?) {
		guard let possibleEmail = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !possibleEmail.isEmpty else {
			return (L10n.Auth.Messages.noEmail, emailTextField)
		}

		guard possibleEmail.isValidEmail else {
			return (L10n.Auth.Messages.invalidEmail, emailTextField)
		}

		guard let possiblePassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !possiblePassword.isEmpty else {
			return (L10n.Auth.Messages.noPassword, passwordTextField)
		}

		return (nil, nil)
	}

}
