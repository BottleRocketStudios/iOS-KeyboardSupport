//
//  KeyboardSafeAreaAdjustable.swift
//  KeyboardSupport
//
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

/// Enables automatic adjustment of additionalSafeAreaInsets when the keyboard is displayed
@available(iOS 11.0, *)
public protocol KeyboardSafeAreaAdjustable {
    func setupKeyboardSafeAreaListener()
    func stopKeyboardSafeAreaListener()
}

@available(iOS 11.0, *)
extension KeyboardSafeAreaAdjustable where Self: UIViewController {
    
    public func setupKeyboardSafeAreaListener() {
        #if swift(>=4.2)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        #else
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        #endif
    }
    
    public func stopKeyboardSafeAreaListener() {
        #if swift(>=4.2)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        #else
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
        #endif
    }
}

@available(iOS 11.0, *)
fileprivate extension UIViewController {
    
    @objc func keyboardFrameWillChange(_ notification: Notification) {
        guard let keyboardInfo = KeyboardInfo(notification: notification) else { return }
        
        let keyboardFrameInView = view.convert(keyboardInfo.finalFrame, from: nil)
        let safeAreaFrame = view.safeAreaLayoutGuide.layoutFrame.insetBy(dx: 0, dy: -additionalSafeAreaInsets.bottom)
        let intersection = safeAreaFrame.intersection(keyboardFrameInView)
        
        UIView.animate(withDuration: keyboardInfo.animationDuration) {
            self.additionalSafeAreaInsets.bottom = intersection.height
            self.view.layoutIfNeeded()
        }
    }
}
