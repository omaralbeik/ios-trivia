//
//  LayoutingViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

/// User LayoutingViewController as a base class for all UIViewController objects.
class LayoutingViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		setGestureRecognizers()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		setNavigationItem()
	}

	func setNavigationItem() {}
	func setGestureRecognizers() {}

}
