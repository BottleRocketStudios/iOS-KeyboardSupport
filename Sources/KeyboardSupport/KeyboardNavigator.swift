//
//  KeyboardNavigator.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 7/28/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

@available(*, deprecated: 2.0, renamed: "KeyboardNavigatorDelegate")
public typealias KeyboardManagerDelegate = KeyboardNavigatorDelegate

/// Contains callbacks for `KeyboardNavigator` navigation options.
public protocol KeyboardNavigatorDelegate: class {
    func keyboardNavigatorDidTapBack(_ navigator: KeyboardNavigator)
    func keyboardNavigatorDidTapNext(_ navigator: KeyboardNavigator)
    func keyboardNavigatorDidTapDone(_ navigator: KeyboardNavigator)
}

@available(*, deprecated: 2.0, renamed: "KeyboardNavigator")
public typealias KeyboardManager = KeyboardNavigator

/// An object for handling navigation between text inputs.
open class KeyboardNavigator {
    
    // MARK: - Properties
    
    public private(set) var textInputs: [UITextInput]
    public private(set) var keyboardToolbar: KeyboardToolbar?
    public private(set) var returnKeyNavigationEnabled: Bool
    public var currentTextInputIndex = 0
    weak open var delegate: KeyboardNavigatorDelegate?
    
    // MARK: - Init
    
    public init(textInputs: [UITextInput], keyboardToolbar: KeyboardToolbar? = nil, returnKeyNavigationEnabled: Bool = false) {
        self.textInputs = textInputs
        self.keyboardToolbar = keyboardToolbar
        self.returnKeyNavigationEnabled = returnKeyNavigationEnabled
        
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
        if let index = textInputs.index(where: { $0 as? UITextField == textField }) {
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
