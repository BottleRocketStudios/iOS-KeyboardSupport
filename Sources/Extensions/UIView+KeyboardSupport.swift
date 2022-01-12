//
//  UIView+KeyboardSupport.swift
//  KeyboardSupport
//
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

extension UIView {
    
    /// highest level superview of the view hierarchy
    var topLevelContainer: UIView {
        var returnView = self
        
        while let superview = returnView.superview {
            returnView = superview
        }
        
        return returnView
    }
    
    /// Computed array of UITextInput subviews. Walks the view hierachy starting with itself to build an array of non-hidden,
    /// UITextInput subviews that can become first responder.
    var textInputViews: [UITextInputView] {
        var fields: [UITextInputView] = []
        
        subviews.forEach { subview in
            guard !subview.isHidden else { return }
            
            if let textField = subview as? UITextInputView, textField.canBecomeFirstResponder, !textField.isHidden {
                fields.append(textField)
            } else {
                fields.append(contentsOf: subview.textInputViews)
            }
        }
        
        return fields
    }
    
    /// Attempts to resign first responder from a subview
    ///
    /// - Returns: Result of resignFirstResponder() or false if active first responder can not be found.
    @discardableResult
    public func resignActiveFirstResponder() -> Bool {
        return activeFirstResponder()?.resignFirstResponder() ?? false
    }
    
    /// Attempts to return a subview that is first responder
    ///
    /// - Returns: The subview that is currently first responder or nil if the first responder can not be found.
    public func activeFirstResponder() -> UIView? {
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
