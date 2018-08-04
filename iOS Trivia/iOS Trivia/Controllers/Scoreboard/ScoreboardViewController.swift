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

	var users: [User] = [] {
		didSet {
			layoutableView.tableView.reloadData()
		}
	}

	override func loadView() {
		view = ViewType()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		layoutableView.tableView.dataSource = self
		layoutableView.tableView.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		fetchUsers(sender: layoutableView)
	}

	override func setNavigationItem() {
		navigationController?.navigationBar.setColors(background: Color.lightOrange, text: Color.white)
		navigationItem.title = L10n.Scoreboard.title
		navigationItem.leftBarButtonItem = .init(image: #imageLiteral(resourceName: "nav_icon_close"), style: .plain, target: self, action: #selector(didTapCancelBarButtonItem))
	}

}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension ScoreboardViewController: UITableViewDataSource, UITableViewDelegate {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier) as! UserTableViewCell
		let row = indexPath.row
		cell.configure(for: users[row], index: row)
		return cell
	}

}

// MARK: - Actions
private extension ScoreboardViewController {

	@objc
	func didTapCancelBarButtonItem() {
		dismiss(animated: true)
	}

}

// MARK: - Networking
private extension ScoreboardViewController {

	func fetchUsers(sender: Loadingable) {

		sender.setLoading(true)
		API.userProvider.request(.all, dataType: UsersResult.self) { result in
			sender.setLoading(false)

			switch result {
			case .failure(let error):
				Alert(serverError: error).show()

			case .success(let users):
				self.users = users.map({ $0.value }).sorted(by: >)
			}
		}
	}

}
