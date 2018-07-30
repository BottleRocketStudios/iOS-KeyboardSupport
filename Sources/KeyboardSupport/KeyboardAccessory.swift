//
//  KeyboardAccessory.swift
//  KeyboardExample
//
//  Created by Earl Gaspard on 7/28/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

/// Contains callbacks for keyboard accessory navigation options.
public protocol KeyboardAccessoryDelegate: class {
    func keyboardAccessoryDidTapBack(_ accessory: UIView)
    func keyboardAccessoryDidTapNext(_ accessory: UIView)
    func keyboardAccessoryDidTapDone(_ accessory: UIView)
}

extension KeyboardAccessoryDelegate {
    func keyboardAccessoryDidTapBack(_ accessory: UIView) {}
    func keyboardAccessoryDidTapNext(_ accessory: UIView) {}
    func keyboardAccessoryDidTapDone(_ accessory: UIView) {}
}

/// Represents something that has keyboard accessory navigation options.
public protocol KeyboardAccessory: class {
    var keyboardAccessoryDelegate: KeyboardAccessoryDelegate? { get set }
}
