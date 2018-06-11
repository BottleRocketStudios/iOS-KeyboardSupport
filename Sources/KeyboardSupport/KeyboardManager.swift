//
//  KeyboardManager.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 12/19/17.
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit

/// Callback when "Done" is tapped either in the input accessory view or the keyboard return key.
public protocol KeyboardManagerDelegate: class {
    func keyboardManagerDidTapDone(_ manager: KeyboardManager)
}

/// Handles navigating between text fields.
/// When a KeyboardInputAccessoryView is provided, the KeyboardManager handles navigation between text fields instead of your view controller.
/// When returnKeyNavigationEnabled is set to 'true', the keyboard's return key is used to navigate to other text fields.
open class KeyboardManager: NSObject {
    
    // MARK: - Typealias
    
    public typealias KeyboardInputAccessoryView = UIView & KeyboardInputAccessory
    
    // MARK: - Properties
    
    public private(set) var textFields: [UITextField] = []
    public private(set) var inputAccessoryView: KeyboardInputAccessoryView?
    public private(set) var returnKeyNavigationEnabled: Bool
    private var currentTextField: UITextField?
    weak open var delegate: KeyboardManagerDelegate?
    
    // MARK: - Init
    
    /// Initializes and returns a newly created KeyboardManager.
    ///
    /// - Parameters:
    ///   - textFields: UITextfields whose order matters for navigating from first to last.
    ///   - inputAccessoryView: An optional KeyboardInputAccessoryView to be shown above the keyboard.
    ///   - returnKeyNavigationEnabled: Indicates whether return keys are used to navigate between text fields. Default is false.
    public init(textFields: [UITextField], inputAccessoryView: KeyboardInputAccessoryView? = nil, returnKeyNavigationEnabled: Bool = false) {
        self.textFields = textFields
        self.inputAccessoryView = inputAccessoryView
        self.returnKeyNavigationEnabled = returnKeyNavigationEnabled
        
        super.init()
        
        self.textFields.forEach {
            $0.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
            $0.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
        }
        
        if let inputAccessoryView = self.inputAccessoryView {
            inputAccessoryView.keyboardInputAccessoryDelegate = self
            self.textFields.forEach { $0.inputAccessoryView = inputAccessoryView }
        }
        
        if self.returnKeyNavigationEnabled {
            self.textFields.forEach { $0.returnKeyType = .next }
            self.textFields.last?.returnKeyType = .done
        }
    }
}

// MARK: - Private

private extension KeyboardManager {
    
    func didTapBack() {
        guard let currentTextField = currentTextField, let index = textFields.index(of: currentTextField), index > 0 else { return }
        textFields[index - 1].becomeFirstResponder()
    }
    
    func didTapNext() {
        guard let currentTextField = currentTextField, let index = textFields.index(of: currentTextField), index < textFields.count - 1 else { return }
        textFields[index + 1].becomeFirstResponder()
    }
    
    func didTapDone() {
        currentTextField?.resignFirstResponder()
        delegate?.keyboardManagerDidTapDone(self)
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        currentTextField = textField
    }
    
    @objc func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        if returnKeyNavigationEnabled {
            switch textField.returnKeyType {
            case .next:
                didTapNext()
            case .done:
                didTapDone()
            default:
                break
            }
        }
    }
}

// MARK: - KeyboardToolbarDelegate

extension KeyboardManager: KeyboardInputAccessoryDelegate {
    
    public func keyboardInputAccessoryDidTapBack(_ inputAccessory: UIView) {
        didTapBack()
    }
    
    public func keyboardInputAccessoryDidTapNext(_ inputAccessory: UIView) {
        didTapNext()
    }
    
    public func keyboardInputAccessoryDidTapDone(_ inputAccessory: UIView) {
        didTapDone()
    }
}
