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
		window?.rootViewController = WelcomeViewController()
		window?.makeKeyAndVisible()
	}

	func setupFirebase() {
		FirebaseApp.configure()
		Database.database().isPersistenceEnabled = true
	}

}
