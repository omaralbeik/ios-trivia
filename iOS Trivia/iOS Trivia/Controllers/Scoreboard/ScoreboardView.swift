//
//  ScoreboardView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

final class ScoreboardView: LayoutableView, Loadingable {

	lazy var tableView: UITableView = {
		let view = UITableView()
		view.allowsSelection = false
		view.separatorInset = .init(top: 0, left: preferredPadding * 4, bottom: 0, right: 0)
		view.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
		return view
	}()

	override func setupViews() {
		super.setupViews()

		addSubview(tableView)
	}

	override func setupLayout() {
		tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
	}

}
