//
//  ScoreboardViewController.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class ScoreboardViewController: LayoutingViewController, Layouting {
	typealias ViewType = ScoreboardView

	override func loadView() {
		view = ViewType()
	}

}

// MARK: - Networking
private extension ScoreboardViewController {

	func fetchUsers() {
		API.userProvider.request(.all, dataType: UsersResult.self) { result in
			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success(let users):
				print(users)
			}
		}
	}

}
