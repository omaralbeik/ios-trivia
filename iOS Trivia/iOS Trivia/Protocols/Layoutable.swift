//
//  Layoutable.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

/// Conform to Layoutable protocol in views you want to layout them using SnapKit.
protocol Layoutable: AnyObject {

	/// Preferred padding for autolayout.
	var preferredPadding: CGFloat { get }

}
