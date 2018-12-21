//
//  UIView+KeyboardSupport.swift
//  KeyboardSupport
//
//  Created by John Davis on 12/3/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

extension UIView {
    
    /// highest level superview of the view hierarchy
    var topLevelContainer: UIView {
        var returnView = self
        
        while returnView.superview != nil {
            returnView = returnView.superview!
        }
        
        return returnView
    }
    
    /// Walks the view hierachy starting with itself to build an array of non-hidden,
    /// UITextInput subviews that can become first responder.
    ///
    /// - Returns: Array of UITextInput subviews
    func getAllTextInputViews() -> [UITextInputView] {
        var fields: [UITextInputView] = []
        
        subviews.forEach { subview in
            guard !subview.isHidden else { return }
            
            if let textField = subview as? UITextInputView, textField.canBecomeFirstResponder, !textField.isHidden {
                fields.append(textField)
            } else {
                fields.append(contentsOf: subview.getAllTextInputViews())
            }
        }
        
        return fields
    }
}
