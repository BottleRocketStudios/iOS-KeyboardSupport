//
//  KeyboardInputAccessory.swift
//  KeyboardSupport
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit

/// Callbacks for navigation and "Done" functionality for a view shown above the keyboard.
public protocol KeyboardInputAccessoryDelegate: class {
    func keyboardInputAccessoryDidTapBack(_ inputAccessory: UIView)
    func keyboardInputAccessoryDidTapNext(_ inputAccessory: UIView)
    func keyboardInputAccessoryDidTapDone(_ inputAccessory: UIView)
}

/// Represents something that has navigation options for a view above the keyboard.
public protocol KeyboardInputAccessory: class {
    var keyboardInputAccessoryDelegate: KeyboardInputAccessoryDelegate? { get set }
}

/// Makes sure the accessory view passed into KeyboardSupportViewController is an UIView that conforms to KeyboardInputAccessory.
public typealias KeyboardInputAccessoryView = UIView & KeyboardInputAccessory
