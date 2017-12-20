//
//  KeyboardInputAccessory.swift
//  KeyboardSupport
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit

/// Callbacks for navigation and "Done" functionality in a keyboard input accessory view that's shown above the keyboard.
public protocol KeyboardInputAccessoryDelegate: class {
    func keyboardInputAccessoryDidTapBack(_ inputAccessory: UIView)
    func keyboardInputAccessoryDidTapNext(_ inputAccessory: UIView)
    func keyboardInputAccessoryDidTapDone(_ inputAccessory: UIView)
}

/// Represents something that has navigation options in an input accessory view above the keyboard.
public protocol KeyboardInputAccessory: class {
    var keyboardInputAccessoryDelegate: KeyboardInputAccessoryDelegate? { get set }
}
