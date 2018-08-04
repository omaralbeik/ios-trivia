//
//  KeyboardNotification.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import UIKit

/// KeyboardNotification.
public class KeyboardNotification: NSObject {

	/// Keyboard start frame.
	private(set) var _startFrame: CGRect!

	/// Keyboard start frame.
	public var startFrame: CGRect {
		return _startFrame

	}

	/// Keyboard end frame.
	private(set) var _endFrame: CGRect!

	/// Keyboard end frame.
	public var endFrame: CGRect {
		return _endFrame
	}

	/// Keyboard animation curve.
	private(set) var _animationCurve: UIViewAnimationCurve!

	/// Keyboard animation curve.
	public var animationCurve: UIViewAnimationCurve {
		return _animationCurve
	}

	/// Keyboard animation duration.
	private(set) var _animationDuration: TimeInterval!

	/// Keyboard animation duration.
	public var animationDuration: TimeInterval {
		return _animationDuration
	}

	/// Whether the keyboard belongs to the current app
	private(set) var _isLocalUser: Bool!

	/// Whether the keyboard belongs to the current app
	public var isLocalUser: Bool {
		return _isLocalUser
	}

	/// Create KeyboardNotification from system Notification.
	///
	/// - Parameter notification: UIKeyboard Notification.
	init?(notification: Notification) {
		guard let userInfo = notification.userInfo else { return nil }
		guard let startFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect else { return nil }
		guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return nil }
		guard let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return nil }
		guard let isLocalUser = userInfo[UIKeyboardIsLocalUserInfoKey] as? Bool else { return nil }

		_startFrame = startFrame
		_endFrame = endFrame

		if let curveRawValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int {
			_animationCurve = UIViewAnimationCurve(rawValue: curveRawValue)
		}

		_animationDuration = animationDuration
		_isLocalUser = isLocalUser
	}

}
