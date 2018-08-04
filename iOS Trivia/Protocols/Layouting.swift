//
//  Layouting.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/1/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

/// Conform to Layouting protocol from a view controller to use layoutableView property.
protocol Layouting: AnyObject {

	/// Type of LayoutableView.
	associatedtype ViewType: LayoutableView

	/// view as ViewType.
	var layoutableView: ViewType { get }

}

// MARK: - Default implementation for UIViewController.
extension Layouting where Self: UIViewController {

	/// view as ViewType.
	var layoutableView: ViewType {
		guard let aView = view as? ViewType else {
			fatalError("view property has not been inialized yet, or not initialized as a \(ViewType.self).")
		}
		return aView
	}

}
