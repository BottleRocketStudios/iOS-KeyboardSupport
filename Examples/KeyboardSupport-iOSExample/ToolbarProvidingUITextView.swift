//
//  ToolbarProvidingTextView.swift
//  KeyboardSupport-iOS
//
//  Created by John Davis on 1/18/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

/// UITextView, when used in with the `KeyboardAutoNavigator` has issues accepting it's toolbar being set in the UITextViewDidBeginEditing notification handler.
/// To workaround this behavior, UITextViews need to set their own inputAccessoryView properties
class ToolbarProvidingTextView: UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let keyboardToolbar = KeyboardToolbar(frame: CGRect(x: 0, y: 0, width: 50.0, height: 44.0))
        keyboardToolbar.addButton(type: .back, title: "Back")
        keyboardToolbar.addButton(type: .next, title: "Next")
        keyboardToolbar.addFlexibleSpace()
        keyboardToolbar.addSystemDoneButton()
        
        inputAccessoryView = keyboardToolbar
    }
}

extension ToolbarProvidingTextView: KeyboardToolbarProviding {
    var keyboardToolbar: KeyboardAccessoryView? {
        return self.inputAccessoryView as? KeyboardToolbar
    }
}
