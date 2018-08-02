//
//  LayoutableView.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit
import SnapKit

class LayoutableView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)

		setupViews()
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		setupViews()
		setupLayout()
	}

	func setupViews() {
		backgroundColor = .white
	}

	func setupLayout() {}

}

// MARK: - Layoutable
extension LayoutableView: Layoutable {

	var preferredPadding: CGFloat {
		return 20.0
	}

}
