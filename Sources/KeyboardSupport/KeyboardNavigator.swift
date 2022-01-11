//
//  KeyboardNavigator.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 7/28/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

@available(*, deprecated, renamed: "KeyboardNavigatorDelegate")
public typealias KeyboardManagerDelegate = KeyboardNavigatorDelegate

/// Contains callbacks for `KeyboardNavigator` navigation options.
public protocol KeyboardNavigatorDelegate: AnyObject {
    func keyboardNavigatorDidTapBack(_ navigator: KeyboardNavigator)
    func keyboardNavigatorDidTapNext(_ navigator: KeyboardNavigator)
    func keyboardNavigatorDidTapDone(_ navigator: KeyboardNavigator)
}

@available(*, deprecated, renamed: "KeyboardNavigator")
public typealias KeyboardManager = KeyboardNavigator

public typealias UITextInputView = UIView & UITextInput

/// Base class for KeyboardNavigators that aggregates a KeyboardToolbar instance and a flag that represents the enabled state of return key navigation
open class KeyboardNavigatorBase {
    public private(set) var keyboardToolbar: KeyboardAccessoryView?
    public private(set) var returnKeyNavigationEnabled: Bool
    
    init(keyboardToolbar: KeyboardAccessoryView? = nil, returnKeyNavigationEnabled: Bool = false) {
        self.keyboardToolbar = keyboardToolbar
        self.returnKeyNavigationEnabled = returnKeyNavigationEnabled
    }
}

/// An object for handling navigation between text inputs.
open class KeyboardNavigator: KeyboardNavigatorBase {
    
    // MARK: - Properties
    
    public private(set) var textInputs: [UITextInput]
    public var currentTextInputIndex = 0
    weak open var delegate: KeyboardNavigatorDelegate?
    
    // MARK: - Init
    
    public init(textInputs: [UITextInput], keyboardToolbar: KeyboardAccessoryView? = nil, returnKeyNavigationEnabled: Bool = false) {
        self.textInputs = textInputs
        
        super.init(keyboardToolbar: keyboardToolbar, returnKeyNavigationEnabled: returnKeyNavigationEnabled)
        
        addTargets()
        addInputAccessoryViews()
    }
    
    // MARK: - Private Methods
    
    private func addTargets() {
        textInputs.forEach {
            if let textField = $0 as? UITextField {
                // Updates currentIndex when a text field is tapped.
                textField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
                // Notifies us when the keyboard's return button is tapped.
                textField.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
            }
        }
    }
    
    private func addInputAccessoryViews() {
        keyboardToolbar?.keyboardAccessoryDelegate = self
        textInputs.forEach {
            if let textField = $0 as? UITextField {
                textField.inputAccessoryView = keyboardToolbar
            } else if let textView = $0 as? UITextView {
                textView.inputAccessoryView = keyboardToolbar
            }
        }
    }
}

// MARK: - Private Extension

private extension KeyboardNavigator {
    
    var currentTextInput: UIResponder? {
        return textInputs[currentTextInputIndex] as? UIResponder
    }
    
    func didTapBack() {
        if currentTextInputIndex > 0 {
            currentTextInputIndex -= 1
            currentTextInput?.becomeFirstResponder()
        }
        
        delegate?.keyboardNavigatorDidTapBack(self)
    }
    
    func didTapNext() {
        if currentTextInputIndex < textInputs.count - 1 {
            currentTextInputIndex += 1
            currentTextInput?.becomeFirstResponder()
        }
        
        delegate?.keyboardNavigatorDidTapNext(self)
    }
    
    func didTapDone() {
        currentTextInput?.resignFirstResponder()
        delegate?.keyboardNavigatorDidTapDone(self)
    }
        
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        if let index = textInputs.firstIndex(where: { $0 as? UITextField == textField }) {
            currentTextInputIndex = index
        }
    }
    
    @objc func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        if textField == textInputs.last as? UITextField {
            didTapDone()
        } else {
            didTapNext()
        }
    }
}

// MARK: - KeyboardAccessoryDelegate

extension KeyboardNavigator: KeyboardAccessoryDelegate {
    
    public func keyboardAccessoryDidTapBack(_ accessory: UIView) {
        didTapBack()
    }
    
    public func keyboardAccessoryDidTapNext(_ accessory: UIView) {
        didTapNext()
    }
    
    public func keyboardAccessoryDidTapDone(_ accessory: UIView) {
        didTapDone()
    }
}
