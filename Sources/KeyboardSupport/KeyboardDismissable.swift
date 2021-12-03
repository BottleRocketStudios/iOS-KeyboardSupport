//
//  KeyboardDismissable.swift
//  KeyboardSupport-iOS
//
//  Created by Earl Gaspard on 4/5/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

/// Enables automatic keyboard dismissal via tapping the screen when the keyboard is displayed.
public protocol KeyboardDismissable: AnyObject {
    /// Must be called once during setup ('viewDidLoad') to enable dismissal.  Returns gesture recognizer used for keyboard dismissal.
    @discardableResult
    func setupKeyboardDismissalView() -> UIGestureRecognizer
}

public extension KeyboardDismissable where Self: UIViewController {
    @discardableResult
    func setupKeyboardDismissalView() -> UIGestureRecognizer {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismissalViewTapped))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        return tapGestureRecognizer
    }
}

extension UIViewController {
    @objc func keyboardDismissalViewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
