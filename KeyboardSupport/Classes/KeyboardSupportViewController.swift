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

/// A subclass of UIViewController for making keyboard interactions easier.
open class KeyboardSupportViewController: UIViewController {
    
    // MARK: - Properties
    
    private var textFields: [UITextField] = []
    private var scrollView: UIScrollView?
    private var bottomConstraint: NSLayoutConstraint?
    private var constraintOffset: CGFloat = 0
    private var usesDismissalView: Bool = false
    private var usesKeyboardNextButtons: Bool = false
    private var keyboardInputAccessoryView: KeyboardInputAccessoryView?
    private var currentTextField: UITextField?
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
    
    /// Configures different types of support for the keyboard.
    ///
    /// - Parameters:
    ///   - textFields: UITextfields whose order matters for navigating from first to last.
    ///   - scrollView: A UIScrollView whose contentInset is updated so the current text field is not hidden. Optional.
    ///   - bottomConstraint: An NSLayoutConstraint to move a view above the keyboard. Optional.
    ///   - constraintOffset: A value to offset the bottomConstraint.
    ///   - usesDismissalView: Allows the keyboard to be dismissed by tapping outside a text field. Default is false.
    ///   - usesKeyboardNextButtons: Allows the keyboard's "return" key to be used to navigate between text fields. Default is false.
    ///   - keyboardInputAccessoryView: A KeyboardInputAccessoryView to show above the keyboard to navigate between text fields. Optional.
    final public func configureKeyboardSupport(with textFields: [UITextField], scrollView: UIScrollView?, bottomConstraint: NSLayoutConstraint?, constraintOffset: CGFloat = 0, usesDismissalView: Bool, usesKeyboardNextButtons: Bool, keyboardInputAccessoryView: KeyboardInputAccessoryView? = nil) {
        self.textFields = textFields
        self.scrollView = scrollView
        self.bottomConstraint = bottomConstraint
        self.constraintOffset = constraintOffset
        self.usesDismissalView = usesDismissalView
        self.usesKeyboardNextButtons = usesKeyboardNextButtons
        self.keyboardInputAccessoryView = keyboardInputAccessoryView
        
        setupTextFields()
        setupKeyboardDismissalView()
    }
    
    final public func moveToNextTextField() {
        guard let currentTextField = currentTextField, let index = textFields.index(of: currentTextField), index < textFields.count - 1 else { return }
        textFields[index + 1].becomeFirstResponder()
    }
    
    final public func moveToPreviousTextField() {
        guard let currentTextField = currentTextField, let index = textFields.index(of: currentTextField), index > 0 else { return }
        textFields[index - 1].becomeFirstResponder()
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
        
        if let scrollView = scrollView {
            var contentInset = scrollView.contentInset
            contentInset.bottom = keyboardFrame.height
            scrollView.contentInset = contentInset
            scrollView.scrollIndicatorInsets = contentInset
        }
        
        if let bottomConstraint = bottomConstraint {
            bottomConstraint.constant = keyboardFrame.height - constraintOffset
            UIView.animate(withDuration: duration, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let userInfo = notification.userInfo, let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        if let scrollView = scrollView {
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero
        }
        
        if let bottomConstraint = bottomConstraint {
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
        textFields.forEach {
            $0.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
            $0.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: .editingDidEndOnExit)
        }
        
        if usesKeyboardNextButtons {
            textFields.forEach { $0.returnKeyType = .next }
            textFields.last?.returnKeyType = .done
        }
        
        if let keyboardInputAccessoryView = keyboardInputAccessoryView {
            keyboardInputAccessoryView.keyboardInputAccessoryDelegate = self
            textFields.forEach { $0.inputAccessoryView = keyboardInputAccessoryView }
        }
    }
    
    func setupKeyboardDismissalView() {
        guard usesDismissalView else { return }
        
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
        if usesKeyboardNextButtons {
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
        moveToNextTextField()
    }
    
    public func keyboardInputAccessoryDidTapNext(_ inputAccessory: UIView) {
        moveToPreviousTextField()
    }
    
    public func keyboardInputAccessoryDidTapDone(_ inputAccessory: UIView) {
        resignCurrentTextField()
    }
}
