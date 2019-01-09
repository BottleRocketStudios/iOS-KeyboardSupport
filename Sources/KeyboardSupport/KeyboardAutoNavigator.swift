//
//  KeyboardAutoNavigator.swift
//  KeyboardSupport-iOS
//
//  Created by John Davis on 12/3/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import Foundation

/// Contains callbacks for `KeyboardAutoNavigator` navigation events.
public protocol KeyboardAutoNavigatorDelegate: class {
    func keyboardNavigatorDidTapBack(_ navigator: KeyboardAutoNavigator)
    func keyboardNavigatorDidTapNext(_ navigator: KeyboardAutoNavigator)
    func keyboardNavigatorDidTapDone(_ navigator: KeyboardAutoNavigator)
}

/// Handles navigating between text fields in a containing view hierarchy.
open class KeyboardAutoNavigator: KeyboardNavigating {
    
    /// AutoPilot is a collection of static functions that enable navigating between UITextInputViews in a view hierarchy
    public enum AutoPilot {
        
        /// Returns the "next" UITextInputView from the provided view within the provided container
        /// The next view is found in a left-to-right, top-to-bottom fashion
        ///
        /// - Parameter origin: UITextInputView to find the next field from
        /// - Returns: The next UITextInputView from the origin, or nil if one could not be found.
        public static func nextField(from origin: UITextInputView, in container: UIView?) -> UITextInputView? {
            let container = container ?? origin.topLevelContainer
            let fields = container.getAllTextInputViews().sortedByPosition(in: container)
            guard let currentFieldIndex = fields.firstIndex(where: { $0 == origin }) else { return nil }
            let nextIndex = min(currentFieldIndex + 1, fields.count - 1) //Add to index or max out
            
            let nextField = fields[nextIndex]
            return (nextField as UIView) != (origin as UIView) ? nextField : nil
        }
        
        /// Returns the "previous" UITextInputView from the provided view.
        /// The previous view is founnd in a right-to-left, bottom-to-top fashion
        ///
        /// - Parameter origin: UITextInputView to find the previous field from
        /// - Returns: The previous UITextInputView from the origin, or nil if one could not be found.
        public static func previousField(from origin: UITextInputView, in container: UIView?) -> UITextInputView? {
            let container = container ?? origin.topLevelContainer
            let fields = container.getAllTextInputViews().sortedByPosition(in: container)
            
            guard let currentFieldIndex = fields.firstIndex(where: { $0 == origin }) else { return nil }
            let previousIndex = max(currentFieldIndex - 1, 0) // subtract from index, or bottom out at zero
            
            let previousField = fields[previousIndex]
            return (previousField as UIView) != (origin as UIView) ? previousField : nil
        }
        
        /// Indicates if a following UITextInputView from the provided view exists.
        ///
        /// - Parameter origin: UITextInputView to find the next field from
        /// - Returns: True if there is a next field. Otherwise false.
        public static func hasNextField(from origin: UITextInputView, in container: UIView?) -> Bool {
            return nextField(from: origin, in: container) != nil
        }
        
        /// Indicates if a preceding UITextInputView from the provided view exists.
        ///
        /// - Parameter origin: UITextInputView to find the previous field from
        /// - Returns: True if there is a previous field. Otherwise false.
        public static func hasPreviousField(from origin: UITextInputView, in container: UIView?) -> Bool {
            return previousField(from: origin, in: container) != nil
        }
    }
    
    // MARK: - Properties
    private var currentTextInputView: UITextInputView? {
        willSet {
            guard let currentTextField = currentTextInputView else { return }
            
            if let toolbar = currentTextField.inputAccessoryView as? KeyboardToolbar {
                toolbar.keyboardAccessoryDelegate = nil
            }
            
            if let control = currentTextField as? UIControl {
                control.removeTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
            }
        }
    }
    
    /// If enabled, the auto navigator will add itself as a target to a UITextField's textFieldEditingDidEndOnExit action and advance to the next field
    public var returnKeyNavigationEnabled: Bool
    
    /// Default toolbar to be populated on a textInput when editting begins. If that text input implemenets "KeyboardToolbarProviding" that input's toolbar will be used instead.
    public var keyboardToolbar: KeyboardToolbar?
    
    /// Containing view of text inputs that can be navigated by the AutoNavigator instance
    private var navigationContainer: UIView

    /// Delegate that will be informed of navigation tap events
    weak open var delegate: KeyboardAutoNavigatorDelegate?
    
    // MARK: - Init
    /// Initializes a KeyboardAutoNavigator
    ///
    /// - Parameters:
    ///   - navigationContainer: Containing view of text inputs that can be navigated by the AutoNavigator instance
    ///   - defaultToolbar: Toolbar to be populated on a textInput when editting begins. If that text input implemenets "KeyboardToolbarProviding" that input's toolbar will be used instead.
    ///   - returnKeyNavigationEnabled: If enabled, the auto navigator will add itself as a target to a UITextField's textFieldEditingDidEndOnExit action and advance to the next field when the return key is tapped.
    public init(navigationContainer: UIView, defaultToolbar: KeyboardToolbar? = nil, returnKeyNavigationEnabled: Bool = true) {
        self.navigationContainer = navigationContainer
        self.keyboardToolbar = defaultToolbar
        self.returnKeyNavigationEnabled = returnKeyNavigationEnabled
        NotificationCenter.default.addObserver(self, selector: #selector(textEditingDidBegin(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textEditingDidBegin(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
    }
    
    public func refreshCurrentToolbarButtonStates() {
        guard let currentTextInput = currentTextInputView,
            let currentToolbar = currentTextInputView?.inputAccessoryView as? KeyboardToolbar else { return }
        
        let hasNext = AutoPilot.hasNextField(from: currentTextInput, in: self.navigationContainer)
        let hasPrevious = AutoPilot.hasPreviousField(from: currentTextInput, in: self.navigationContainer)
        
        if !hasNext && !hasPrevious {
            currentToolbar.setNextAndBackButtonsHidden(hidden: true)
        } else {
            currentToolbar.setNextAndBackButtonsHidden(hidden: false)
            
            currentToolbar.backButton?.isEnabled = hasPrevious
            currentToolbar.nextButton?.isEnabled = hasNext
        }
    }
}

// MARK: - UI Event Handlers
extension KeyboardAutoNavigator {
    @objc
    private func textEditingDidBegin(_ notification: Notification) {
        guard let inputView = notification.object as? UITextInputView,
            inputView.isDescendant(of: self.navigationContainer) else { return }
        currentTextInputView = inputView
        
        if returnKeyNavigationEnabled, let controlInput = currentTextInputView as? UIControl {
            controlInput.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        }
        
        if let toolbarProvidingInputView = inputView as? KeyboardToolbarProviding {
            applyToolbar(toolbarProvidingInputView.keyboardToolbar, toTextInput: inputView)
        } else {
            applyToolbar(keyboardToolbar, toTextInput: inputView)
        }
        
        // There's a chance that the TextInput gaining first responder will trigger a containing scroll view to scroll new textfields into view.
        // We want to try to refresh our toolbar buttons after the scrollview has settled so those new views are taken into consideration. Using
        // async here is a "best effort" approach. If your app has an opportunity to call this method at a more concrete time, such as in
        // ScrollViewDidEndDragging, or ScrollViewDidEndDecelerating, do so for the best results.
        DispatchQueue.main.async {
            self.refreshCurrentToolbarButtonStates()
        }
    }
    
    @objc
    private func textFieldEditingDidEndOnExit(_ sender: UITextInputView) {
        if returnKeyNavigationEnabled {
            AutoPilot.nextField(from: sender, in: navigationContainer)?.becomeFirstResponder()
        }
    }
}

// MARK: - Helpers
extension KeyboardAutoNavigator {
    private func applyToolbar(_ toolbar: KeyboardToolbar?, toTextInput textInput: UITextInputView) {
        toolbar?.keyboardAccessoryDelegate = self

        if let textInput = textInput as? UITextField {
            textInput.inputAccessoryView = toolbar
        } else if let textInput = textInput as? UITextView {
            textInput.inputAccessoryView = toolbar
        }
    }
}

// MARK: - KeyboardAccessoryDelegate
extension KeyboardAutoNavigator: KeyboardAccessoryDelegate {
    public func didTapBack() {
        defer {
            delegate?.keyboardNavigatorDidTapBack(self)
        }
        
        guard let currentTextField = currentTextInputView else { return }
        AutoPilot.previousField(from: currentTextField, in: navigationContainer)?.becomeFirstResponder()
    }
    
    public func didTapNext() {
        defer {
            delegate?.keyboardNavigatorDidTapNext(self)
        }
        
        guard let currentTextField = currentTextInputView else { return }
        AutoPilot.nextField(from: currentTextField, in: navigationContainer)?.becomeFirstResponder()
    }
    
    public func didTapDone() {
        currentTextInputView?.resignFirstResponder()
        delegate?.keyboardNavigatorDidTapDone(self)
    }
    
    public func keyboardAccessoryDidTapBack(_ inputAccessory: UIView) {
        didTapBack()
    }
    
    public func keyboardAccessoryDidTapNext(_ inputAccessory: UIView) {
        didTapNext()
    }
    
    public func keyboardAccessoryDidTapDone(_ inputAccessory: UIView) {
        didTapDone()
    }
}
