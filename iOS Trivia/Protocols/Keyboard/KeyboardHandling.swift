//
//  KeyboardHandling.swift
//  iOS Trivia
//
//  Created by Omar Albeik on 8/3/18.
//  Copyright © 2018 Omar Albeik. All rights reserved.
//

import Foundation

/// Conform to KeyboardHandling protocol to handle UIKeyboard events in a view.
public protocol KeyboardHandling: AnyObject {

	/// Call this method from view contoller to handle KeyboardWillShow notification.
	///
	/// - Parameter notification: keyboard notificaton sent from system.
	func keyboardWillShow(_ notification: KeyboardNotification?)

	/// Call this method from view contoller to handle handleKeyboardDidShow notification.
	///
	/// - Parameter notification: keyboard notificaton sent from system.
	func keyboardDidShow(_ notification: KeyboardNotification?)

	/// Call this method from view contoller to handle handleKeyboardWillHide notification.
	///
	/// - Parameter notification: keyboard notificaton sent from system.
	func keyboardWillHide(_ notification: KeyboardNotification?)

	/// Call this method from view contoller to handle handleKeyboardDidHide notification.
	///
	/// - Parameter notification: keyboard notificaton sent from system.
	func keyboardDidHide(_ notification: KeyboardNotification?)

	/// Call this method from view contoller to handle handleKeyboardWillChangeFrame notification.
	///
	/// - Parameter notification: keyboard notificaton sent from system.
	func keyboardWillChangeFrame(_ notification: KeyboardNotification?)

	/// Call this method from view contoller to handle handleKeyboardDidChangeFrame notification.
	///
	/// - Parameter notification: keyboard notificaton sent from system.
	func keyboardDidChangeFrame(_ notification: KeyboardNotification?)

}
