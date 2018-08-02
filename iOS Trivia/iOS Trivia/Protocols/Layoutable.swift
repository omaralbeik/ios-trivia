//
//  Layoutable.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

protocol Layoutable: AnyObject {

	/// Preferred padding for autolayout.
	var preferredPadding: CGFloat { get }

}
