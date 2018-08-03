//
//  AppDelegate.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		setupWindow()
		setupFirebase()

		return true
	}

}

// MARK: - Setup
private extension AppDelegate {

	func setupWindow() {
		window = UIWindow()
		AuthCache.hasRefreshToken ? showWelcomeViewController(animated: false) : showAuthViewController(animated: false)
		window?.makeKeyAndVisible()
	}

	func setupFirebase() {
		FirebaseApp.configure()
	}

}

extension AppDelegate {

	func showWelcomeViewController(animated: Bool = true) {
		window?.switchRootViewController(to: WelcomeViewController(), animated: animated, options: .transitionFlipFromRight)
	}

	func showAuthViewController(animated: Bool = true) {
		window?.switchRootViewController(to: AuthViewController(), animated: animated, options: .transitionFlipFromRight)
	}

}
