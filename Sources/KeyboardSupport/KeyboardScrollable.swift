//
//  KeyboardScrollable.swift
//  KeyboardSupport-iOS
//
//  Created by Earl Gaspard on 4/5/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

/// KeyboardScrollable will ask a UITextInputView that conforms to this protocol for preferred distance between the field and the keyboard.
/// It will be used if it is non-nil and greater than the KeyboardScrollable's `minimumPaddingAroundInput`.
public protocol KeyboardPaddingProviding {
    var inputPadding: UIEdgeInsets { get }
}

// MARK: - KeyboardInfo

/// Stores info about the keyboard.
public struct KeyboardInfo {
    public let initialFrame: CGRect
    public let finalFrame: CGRect
    public let animationDuration: TimeInterval
    public let animationCurve: UInt
    
    public init?(notification: Notification) {
        #if swift(>=4.2)
        guard let userInfo = notification.userInfo,
            let initialKeyboardFrame = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
            let finalKeyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
                return nil
        }
        #else
        guard let userInfo = notification.userInfo,
            let initialKeyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            let finalKeyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt else {
                return nil
        }
        #endif
        
        initialFrame = initialKeyboardFrame
        finalFrame = finalKeyboardFrame
        animationDuration = duration
        animationCurve = curve
    }
    
    public var isMoving: Bool {
        return initialFrame.origin != finalFrame.origin
    }
}

// MARK: - KeyboardScrollable

/// Enables scrolling views to the first responder when a keyboard is shown. Must be used with a UIScrollView or one of its subclasses.
public protocol KeyboardScrollable: class {
    var minimumPaddingAroundInput: UIEdgeInsets { get }
    
    var keyboardScrollableScrollView: UIScrollView? { get }
    var keyboardWillShowObserver: NSObjectProtocol? { get set }
    var keyboardWillHideObserver: NSObjectProtocol? { get set }
    
    var preservesContentInsetWhenKeyboardVisible: Bool { get }
    
    /// Must be called during screen appearance ('viewWillAppear') to allow for keyboard notification observers to be registered.
    func setupKeyboardObservers()
    
    /// Must be called during screen disappearance ('viewWillDisappear') to allow for keyboard notification observers to be unregistered.
    func removeKeyboardObservers()
    
    /// Called when the keyboard is showing.
    func keyboardWillShow(keyboardInfo: KeyboardInfo)
    
    /// Called when the keyboard is hiding.
    func keyboardWillHide(keyboardInfo: KeyboardInfo)
}

public extension KeyboardScrollable where Self: UIViewController {
    
    // MARK: KeyboardScrollable Conformance
    var minimumPaddingAroundInput: UIEdgeInsets {
        return .zero
    }
    
    var preservesContentInsetWhenKeyboardVisible: Bool { return true }
    
    func setupKeyboardObservers() {
        keyboardScrollableScrollView?.originalContentInset = keyboardScrollableScrollView?.contentInset
        
        let keyboardWillShowNotificationName: Notification.Name = {
            #if swift(>=4.2)
            return UIResponder.keyboardWillShowNotification
            #else
            return .UIKeyboardWillShow
            #endif
        }()
        let keyboardWillHideNotificationName: Notification.Name = {
            #if swift(>=4.2)
            return UIResponder.keyboardWillHideNotification
            #else
            return .UIKeyboardWillHide
            #endif
        }()
        
        keyboardWillShowObserver = NotificationCenter.default.addObserver(forName: keyboardWillShowNotificationName, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            guard let keyboardInfo = KeyboardInfo(notification: notification), let activeField = self?.view.activeFirstResponder() else { return }
            self?.adjustViewForKeyboardAppearance(with: keyboardInfo, firstResponder: activeField)
            self?.keyboardWillShow(keyboardInfo: keyboardInfo)
        })
        keyboardWillHideObserver = NotificationCenter.default.addObserver(forName: keyboardWillHideNotificationName, object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            guard let keyboardInfo = KeyboardInfo(notification: notification) else { return }
            self?.resetViewForKeyboardDisappearance(with: keyboardInfo)
            self?.keyboardWillHide(keyboardInfo: keyboardInfo)
        })
    }
    
    func removeKeyboardObservers() {
        keyboardScrollableScrollView?.originalContentInset.flatMap { keyboardScrollableScrollView?.contentInset = $0 }
        if let keyboardWillShowObserver = keyboardWillShowObserver {
            NotificationCenter.default.removeObserver(keyboardWillShowObserver)
        }
        if let keyboardWillHideObserver = keyboardWillHideObserver {
            NotificationCenter.default.removeObserver(keyboardWillHideObserver)
        }
    }
    
    func keyboardWillShow(keyboardInfo: KeyboardInfo) {
        // No-op by default. Opt-in by implementing this method in your class conforming to KeyboardScrollable.
    }
    
    func keyboardWillHide(keyboardInfo: KeyboardInfo) {
        // No-op by default. Opt-in by implementing this method in your class conforming to KeyboardScrollable.
    }
    
    // MARK: Private Methods
    
    private func adjustViewForKeyboardAppearance(with keyboardInfo: KeyboardInfo, firstResponder: UIView) {
        guard let scrollView = keyboardScrollableScrollView else { return }
        
        var mutableInset: UIEdgeInsets
        if preservesContentInsetWhenKeyboardVisible, let originalContentInset = scrollView.originalContentInset {
            mutableInset = originalContentInset
        } else {
            mutableInset = .zero
        }
        
        // Adjust scroll view insets for keyboard height
        let keyboardHeight = keyboardInfo.finalFrame.height
        if #available(iOS 11.0, *) {
            mutableInset.bottom += keyboardHeight - view.safeAreaInsets.bottom
        } else {
            mutableInset.bottom += keyboardHeight
        }
        
        adjustScrollViewInset(mutableInset, keyboardInfo: keyboardInfo)
        
        // If active text field is hidden by keyboard, scroll so it's visible
        if let textView = firstResponder as? UITextView {
            scrollToSelectedText(for: textView, keyboardInfo: keyboardInfo)
        } else {
            let preferredPaddingAroundInput = (firstResponder as? KeyboardPaddingProviding)?.inputPadding ?? .zero
            scrollToRectIfNecessary(rect: firstResponder.bounds, of: firstResponder, keyboardInfo: keyboardInfo, preferredPaddingAroundInput: preferredPaddingAroundInput)
        }
    }
    
    private func scrollToSelectedText(for textView: UITextView, keyboardInfo: KeyboardInfo) {
        // Get the frame of the cursor/selection to improve scrolling position for UITextView's
        // DispatchQueue.async() is necessary because the selectedTextRange typically hasn't not been updated when UIResponder.keyboardWillShowNotification is posted
        DispatchQueue.main.async {
            guard let textRange = textView.selectedTextRange, let selectionRect = textView.selectionRects(for: textRange).first else { return }
            // Set an arbitrary width to the target CGRect in case the width is zero. Otherwise, scrollRectToVisible has no effect.
            self.scrollToRectIfNecessary(rect: selectionRect.rect.modifying(width: 1), of: textView, keyboardInfo: keyboardInfo)
        }
    }
    
    private func scrollToRectIfNecessary(rect: CGRect, of coordinateSpaceView: UIView, keyboardInfo: KeyboardInfo, preferredPaddingAroundInput: UIEdgeInsets = .zero) {
        guard let scrollView = keyboardScrollableScrollView else { return }
        
        let paddingAroundInput = UIEdgeInsets.max(lhs: preferredPaddingAroundInput, rhs: minimumPaddingAroundInput)
        
        // Inflate the frame being scrolled into view by the padding
        let paddedFrameOfFirstResponder = rect.modifying(minY: rect.minY - paddingAroundInput.top)
            .modifying(minX: rect.minX - paddingAroundInput.left)
            .modifying(height: rect.height + paddingAroundInput.top + paddingAroundInput.bottom)
            .modifying(width: rect.width + paddingAroundInput.left + paddingAroundInput.right)
        
        // Convert the padded rect to the scrollview coordinate space and scroll it into view
        let paddedFrameOfFirstResponderInScrollView = coordinateSpaceView.convert(paddedFrameOfFirstResponder, to: scrollView)
        UIView.animate(withDuration: keyboardInfo.animationDuration, delay: 0, options: [UIView.AnimationOptions(rawValue: keyboardInfo.animationCurve)], animations: {
            scrollView.scrollRectToVisible(paddedFrameOfFirstResponderInScrollView, animated: false)
        }, completion: nil)
    }
    
    private func resetViewForKeyboardDisappearance(with keyboardInfo: KeyboardInfo) {
        guard let scrollView = keyboardScrollableScrollView else { return }
        let originalContentInset = scrollView.originalContentInset ?? .zero
        adjustScrollViewInset(originalContentInset, keyboardInfo: keyboardInfo)
    }
    
    private func adjustScrollViewInset(_ inset: UIEdgeInsets, keyboardInfo: KeyboardInfo) {
        UIView.animate(withDuration: keyboardInfo.animationDuration, delay: 0, options: [UIView.AnimationOptions(rawValue: keyboardInfo.animationCurve)], animations: {
            self.keyboardScrollableScrollView?.contentInset = inset
            self.keyboardScrollableScrollView?.scrollIndicatorInsets = inset
        }, completion: nil)
    }
}
