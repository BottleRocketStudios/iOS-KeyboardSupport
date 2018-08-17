//
//  KeyboardSafeAreaAdjustable.swift
//  KeyboardSupport-iOS
//
//  Created by Cuong Ngo on 7/31/18.
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameWillChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }
    
    public func stopKeyboardSafeAreaListener() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
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
