//
//  KeyboardRespondable.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 12/19/17.
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit

// MARK: - KeyboardRespondable

/// Inherits from both KeyboardDismissable and KeyboardScrollable for convenience.
public protocol KeyboardRespondable: KeyboardDismissable, KeyboardScrollable {
    /// Must be called during setup ('viewDidLoad') so keyboard dismissal and responsiveness can be enabled.
    func setupKeyboardRespondable()
}

public extension KeyboardRespondable where Self: UIViewController {
    func setupKeyboardRespondable() {
        setupKeyboardDismissalView()
    }
}

// MARK: - KeyboardDismissable

/// Enables automatic keyboard dismissal via tapping the screen when the keyboard is displayed.
public protocol KeyboardDismissable: class {
    /// Must be called once during setup ('viewDidLoad') to enable dismissal.
    func setupKeyboardDismissalView()
}

public extension KeyboardDismissable where Self: UIViewController {
    func setupKeyboardDismissalView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismissalViewTapped))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension UIViewController {
    @objc func keyboardDismissalViewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - KeyboardScrollable

/// Stores info about the keyboard.
struct KeyboardInfo {
    let initialFrame: CGRect
    let finalFrame: CGRect
    let animationDuration: TimeInterval
    
    init?(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let initialKeyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let finalKeyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                return nil
        }
        
        initialFrame = initialKeyboardFrame
        finalFrame = finalKeyboardFrame
        animationDuration = duration
    }
    
    var isMoving: Bool {
        return initialFrame.origin != finalFrame.origin
    }
}

/// Enables scrolling views to the first responder when a keyboard is shown. Must be used with a UIScrollView or one of its subclasses.
public protocol KeyboardScrollable: class {
    var keyboardScrollableScrollView: UIScrollView? { get set }
    var keyboardWillShowObserver: NSObjectProtocol? { get set }
    var keyboardWillHideObserver: NSObjectProtocol? { get set }
    
    /// Must be called during screen appearance ('viewWillAppear') to allow for keyboard notification observers to be registered.
    func setupKeyboardObservers()
    
    /// Must be called during screen disappearance ('viewWillDisappear') to allow for keyboard notification observers to be unregistered.
    func removeKeyboardObservers()
}

public extension KeyboardScrollable where Self: UIViewController {
    
    func setupKeyboardObservers() {
        keyboardWillShowObserver = NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            guard let keyboardInfo = KeyboardInfo(notification: notification), keyboardInfo.isMoving, let activeField = self?.view.activeFirstResponder() else { return }
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
        guard let contentInset = keyboardScrollableScrollView?.contentInset else { return }
        
        // Adjust scroll view insets for keyboard height
        let keyboardSize = keyboardInfo.finalFrame.size
        
        var mutableInset = contentInset
        mutableInset.bottom += keyboardSize.height
        adjustScrollViewInset(mutableInset)
        
        // If active text field is hidden by keyboard, scroll so it's visible
        let keyboardMinY = view.bounds.height - keyboardSize.height
        
        let firstResponderConvertedFrame = firstResponder.convert(firstResponder.bounds, to: nil)
        let firstResponderMaxY = firstResponderConvertedFrame.maxY
        
        if firstResponderMaxY > keyboardMinY {
            keyboardScrollableScrollView?.scrollRectToVisible(firstResponder.frame, animated: true)
        }
    }
    
    private func resetViewForKeyboardDisappearance(with keyboardInfo: KeyboardInfo) {
        adjustScrollViewInset(.zero)
    }
    
    private func adjustScrollViewInset(_ inset: UIEdgeInsets) {
        keyboardScrollableScrollView?.contentInset = inset
        keyboardScrollableScrollView?.scrollIndicatorInsets = inset
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
