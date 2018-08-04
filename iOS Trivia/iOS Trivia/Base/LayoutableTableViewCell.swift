//
//  LayoutableTableViewCell.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/4/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import SnapKit

/// Use LayoutableTableViewCell as a base class for all UITableViewCell objects.
class LayoutableTableViewCell: UITableViewCell {

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupViews()
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		setupViews()
		setupLayout()
	}

	func setupViews() {
		backgroundColor = Color.white
		selectionStyle = .none
	}

	func setupLayout() {}

}

// MARK: - Layoutable
extension LayoutableTableViewCell: Layoutable {

	var preferredPadding: CGFloat {
		return 20.0
	}

}
