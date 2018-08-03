//
//  AuthView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/2/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class AuthView: LayoutableView {

	lazy var modeSegmentedControl: UISegmentedControl = {
		let control = UISegmentedControl(items: [L10n.Auth.Mode.login, L10n.Auth.Mode.register])
		control.selectedSegmentIndex = 0
		control.tintColor = .black
		return control
	}()

	lazy var emailTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = L10n.Auth.emailAddress
		textField.keyboardType = .emailAddress
		if #available(iOS 10.0, *) {
			textField.textContentType = .emailAddress
		}
		return setTextFieldStyle(textField)
	}()

	lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = L10n.Auth.password
		textField.isSecureTextEntry = true
		if #available(iOS 11.0, *) {
			textField.textContentType = .password
		}
		return setTextFieldStyle(textField)
	}()

	lazy var actionButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle(L10n.Auth.Action.login, for: .normal)
		button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
		button.backgroundColor = .black
		button.tintColor = .white
		button.layer.cornerRadius = preferredPadding / 3
		return button
	}()

	lazy var stackView: UIStackView = {
		let view = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
		view.axis = .vertical
		view.alignment = .fill
		view.distribution = .fillEqually
		view.spacing = preferredPadding / 2
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(modeSegmentedControl)
		addSubview(stackView)
		addSubview(actionButton)
	}

	override func setupLayout() {
		modeSegmentedControl.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(preferredPadding * 2)
			make.leading.trailing.equalToSuperview().inset(preferredPadding)
			make.height.equalTo(preferredPadding * 2)
		}

		emailTextField.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2.5) }
		passwordTextField.snp.makeConstraints { $0.height.equalTo(preferredPadding * 2.5) }

		stackView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(preferredPadding)
			make.top.equalTo(modeSegmentedControl.snp.bottom).offset(preferredPadding)
		}

		actionButton.snp.makeConstraints { make in
			make.top.equalTo(stackView.snp.bottom).offset(preferredPadding)
			make.leading.trailing.equalTo(stackView)
			make.height.equalTo(preferredPadding * 2.5)
			make.centerX.equalToSuperview()
		}
	}
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

// MARK: - Helpers
private extension AuthView {

	func setTextFieldStyle(_ textField: UITextField) -> UITextField {
		textField.textAlignment = .center
		textField.autocapitalizationType = .none
		textField.autocorrectionType = .no
		textField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
		textField.textColor = .black
		textField.layer.cornerRadius = preferredPadding / 3
		return textField
	}

}
