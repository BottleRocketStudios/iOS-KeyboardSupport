//
//  KeyboardSupportViewController.swift
//  KeyboardSupport
//
//  Copyright © 2018 Bottle Rocket Studios. All rights reserved.
//

import UIKit

/// Callback when the "Done" button is tapped.
public protocol KeyboardSupportDelegate: class {
    func didTapDoneButton()
}

/// A model composed of different options for supporting the keyboard.
public struct KeyboardSupportConfiguration {
    public var textFields: [UITextField] = []
    public var scrollView: UIScrollView?
    public var bottomConstraint: NSLayoutConstraint?
    public var constraintOffset: CGFloat = 0
    public var usesDismissalView: Bool = false
    public var usesKeyboardNextButtons: Bool = false
    public var keyboardInputAccessoryView: KeyboardInputAccessoryView?
    
    public init(textFields: [UITextField] = [], scrollView: UIScrollView? = nil, bottomConstraint: NSLayoutConstraint? = nil, constraintOffset: CGFloat = 0, usesDismissalView: Bool = false, usesKeyboardNextButtons: Bool = false, keyboardInputAccessoryView: KeyboardInputAccessoryView? = nil) {
        self.textFields = textFields
        self.scrollView = scrollView
        self.bottomConstraint = bottomConstraint
        self.constraintOffset = constraintOffset
        self.usesDismissalView = usesDismissalView
        self.usesKeyboardNextButtons = usesKeyboardNextButtons
        self.keyboardInputAccessoryView = keyboardInputAccessoryView
    }
}

/// A subclass of UIViewController for making keyboard interactions easier.
open class KeyboardSupportViewController: UIViewController {
    
    // MARK: - Properties
    
    public private(set) var configuration = KeyboardSupportConfiguration()
    public private(set) var currentTextField: UITextField?
    public weak var keyboardSupportDelegate: KeyboardSupportDelegate?
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Public
    
    final public func configureKeyboardSupport(with configuration: KeyboardSupportConfiguration) {
        self.configuration = configuration
        setupTextFields()
        setupKeyboardDismissalView()
    }
    
    final public func moveToNextTextField() {
        guard let currentTextField = currentTextField, let index = configuration.textFields.index(of: currentTextField), index < configuration.textFields.count - 1 else { return }
        configuration.textFields[index + 1].becomeFirstResponder()
    }
    
    final public func moveToPreviousTextField() {
        guard let currentTextField = currentTextField, let index = configuration.textFields.index(of: currentTextField), index > 0 else { return }
        configuration.textFields[index - 1].becomeFirstResponder()
    }
    
    final public func resignCurrentTextField() {
        currentTextField?.resignFirstResponder()
        keyboardSupportDelegate?.didTapDoneButton()
    }
}

// MARK: - Notifications

private extension KeyboardSupportViewController {
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        if let scrollView = configuration.scrollView {
            var contentInset = scrollView.contentInset
            contentInset.bottom = keyboardFrame.height
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
        
        if let bottomConstraint = configuration.bottomConstraint {
            bottomConstraint.constant = keyboardFrame.height - configuration.constraintOffset
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        if let scrollView = configuration.scrollView {
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
        
        if let bottomConstraint = configuration.bottomConstraint {
            bottomConstraint.constant = 0
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
}

// MARK: - Private

private extension KeyboardSupportViewController {
    
    func setupTextFields() {
        configuration.textFields.forEach {
            $0.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
            $0.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
        }
        
        if configuration.usesKeyboardNextButtons {
            configuration.textFields.forEach { $0.returnKeyType = .next }
            configuration.textFields.last?.returnKeyType = .done
        }
        
        if let keyboardInputAccessoryView = configuration.keyboardInputAccessoryView {
            keyboardInputAccessoryView.keyboardInputAccessoryDelegate = self
            configuration.textFields.forEach { $0.inputAccessoryView = keyboardInputAccessoryView }
        }
    }
    
    func setupKeyboardDismissalView() {
        guard configuration.usesDismissalView else { return }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardDismissalViewTapped))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func keyboardDismissalViewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        currentTextField = textField
    }
    
    @objc func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        if configuration.usesKeyboardNextButtons {
            switch textField.returnKeyType {
            case .next:
                moveToNextTextField()
            case .done:
                resignCurrentTextField()
            default:
                break
            }
        }
    }
}

// MARK: - KeyboardInputAccessoryDelegate

extension KeyboardSupportViewController: KeyboardInputAccessoryDelegate {
    
    public func keyboardInputAccessoryDidTapBack(_ inputAccessory: UIView) {
        moveToPreviousTextField()
    }
    
    public func keyboardInputAccessoryDidTapNext(_ inputAccessory: UIView) {
        moveToNextTextField()
    }
    
    public func keyboardInputAccessoryDidTapDone(_ inputAccessory: UIView) {
        resignCurrentTextField()
    }
}
