//
//  KeyboardRespondable.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 12/19/17.
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit

// MARK: - KeyboardRespondable

/// Inherits from both KeyboardDismissable and KeyboardScrollable.
public protocol KeyboardRespondable: KeyboardDismissable, KeyboardScrollable {}

// MARK: - KeyboardDismissable

/// Enables automatic keyboard dismissal via tapping the screen when the keyboard is displayed.
public protocol KeyboardDismissable: class {
    /// Must be called in `viewDidLoad()` to enable dismissal.
    func setupKeyboardDismissal()
}

public extension KeyboardDismissable where Self: UIViewController {
    func setupKeyboardDismissal() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension UIViewController {
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - KeyboardScrollable

/// Stores info about the keyboard.
struct KeyboardInfo {
    let finalFrame: CGRect
    let animationDuration: TimeInterval
    
    init?(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let finalFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return nil
        }

        self.finalFrame = finalFrame
        self.animationDuration = animationDuration
    }
}

/// Enables scrolling views to the first responder when a keyboard is shown. Must be used with a UIScrollView or one of its subclasses.
public protocol KeyboardScrollable: class {
    var keyboardScrollableScrollView: UIScrollView? { get set }
    var keyboardWillShowObserver: NSObjectProtocol? { get set }
    var keyboardWillHideObserver: NSObjectProtocol? { get set }
    
    /// Must be called in `viewDidLoad()` to add keyboard notification observers.
    func addKeyboardObservers()
    
    /// Must be called in `deinit` to remove keyboard notification observers.
    func removeKeyboardObservers()
}

public extension KeyboardScrollable where Self: UIViewController {
    
    func addKeyboardObservers() {
        keyboardWillShowObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            guard let keyboardInfo = KeyboardInfo(notification: notification), let activeField = self?.view.activeFirstResponder() else { return }
            self?.adjustViewForKeyboardAppearance(with: keyboardInfo, firstResponder: activeField)
        })
        keyboardWillHideObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            guard let keyboardInfo = KeyboardInfo(notification: notification) else { return }
            self?.resetViewForKeyboardDisappearance(with: keyboardInfo)
        })
    }
    
    func removeKeyboardObservers() {
        if let keyboardWillShowObserver = keyboardWillShowObserver {
            NotificationCenter.default.removeObserver(keyboardWillShowObserver)
        }
        if let keyboardWillHideObserver = keyboardWillHideObserver {
            NotificationCenter.default.removeObserver(keyboardWillHideObserver)
        }
    }
    
    private func adjustViewForKeyboardAppearance(with keyboardInfo: KeyboardInfo, firstResponder: UIView) {
        // Adjust scroll view insets for keyboard height
        let keyboardSize = keyboardInfo.finalFrame.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        adjustScrollViewInset(contentInsets, animationDuration: 0)

        // If active first responder is hidden by the keyboard, scroll it so it's visible
        var aRect = firstResponder.frame
        aRect.size.height -= keyboardSize.height
        if !aRect.contains(firstResponder.frame.origin) {
            UIView.animate(withDuration: keyboardInfo.animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.keyboardScrollableScrollView?.scrollRectToVisible(firstResponder.frame, animated: false)
            }, completion: nil)
        }
    }
    
    private func resetViewForKeyboardDisappearance(with keyboardInfo: KeyboardInfo) {
        adjustScrollViewInset(.zero, animationDuration: keyboardInfo.animationDuration)
    }
    
    private func adjustScrollViewInset(_ inset: UIEdgeInsets, animationDuration: TimeInterval) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.keyboardScrollableScrollView?.contentInset = inset
            self.keyboardScrollableScrollView?.scrollIndicatorInsets = inset
        }, completion: nil)
    }
}

// MARK: - UIView Extensions

extension UIView {
    
    /// Returns the view that is the first responder
    func activeFirstResponder() -> UIView? {
        return UIView.activeFirstResponder(for: self)
    }
    
    /// Static helper method to get the view that is the first responder
    static func activeFirstResponder(for view: UIView) -> UIView? {
        guard !view.isFirstResponder else { return view }
        
        for subview in view.subviews {
            if let firstResponder = activeFirstResponder(for: subview) {
                return firstResponder
            }
        }
        
        return nil
    }
}
