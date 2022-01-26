//
//  KeyboardAutoNavigator.swift
//  KeyboardSupport
//
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

/// Contains callbacks for `KeyboardAutoNavigator` navigation events.
public protocol KeyboardAutoNavigatorDelegate: AnyObject {
    func keyboardAutoNavigatorDidTapBack(_ navigator: KeyboardAutoNavigator)
    func keyboardAutoNavigatorDidTapNext(_ navigator: KeyboardAutoNavigator)
    func keyboardAutoNavigatorDidTapDone(_ navigator: KeyboardAutoNavigator)
}

/// Handles navigating between text fields in a containing view hierarchy.
open class KeyboardAutoNavigator: KeyboardNavigatorBase {
    
    /// AutoPilot is a collection of static functions that enable navigating between `UITextInputViews` in a view hierarchy
    public enum AutoPilot {
        
        /// Returns the "next" `UITextInputView` from the provided view within the provided container
        /// The next view is found in a left-to-right, top-to-bottom fashion
        ///
        /// - Parameters:
        ///   - source: `UITextInputView` to find the next field from
        ///   - container: Optional form container. If nil, the top-level container of the source will be determined and used.
        /// - Returns: The next `UITextInputView` from the source, or nil if one could not be found.
        public static func nextField(from source: UITextInputView, in container: UIView?) -> UITextInputView? {
            let fields = sortedFields(around: source, in: container)
            
            guard let currentFieldIndex = fields.firstIndex(where: { $0 == source }) else { return nil }
            let nextIndex = min(currentFieldIndex + 1, fields.count - 1) // Add to index or max out
            
            let nextField = fields[nextIndex]
            return (nextField as UIView) != (source as UIView) ? nextField : nil
        }
        
        /// Returns the "previous" `UITextInputView` from the provided view.
        /// The previous view is found in a right-to-left, bottom-to-top fashion
        ///
        /// - Parameters:
        ///   - source: `UITextInputView` to find the previous field from
        ///   - container: Optional form container. If nil, the top-level container of the source will be determined and used.
        /// - Returns: The previous `UITextInputView` from the source, or nil if one could not be found.
        public static func previousField(from source: UITextInputView, in container: UIView?) -> UITextInputView? {
            let fields = sortedFields(around: source, in: container)
            
            guard let currentFieldIndex = fields.firstIndex(where: { $0 == source }) else { return nil }
            let previousIndex = max(currentFieldIndex - 1, 0) // Subtract from index, or bottom out at zero
            
            let previousField = fields[previousIndex]
            return (previousField as UIView) != (source as UIView) ? previousField : nil
        }
        
        /// Indicates if a following `UITextInputView` from the provided view exists.
        ///
        /// - Parameters:
        ///   - source: `UITextInputView` to find the next field from
        ///   - container: Optional form container. If nil, the top-level container of the source will be determined and used.
        /// - Returns: True if there is a next field. Otherwise false.
        public static func hasNextField(from source: UITextInputView, in container: UIView?) -> Bool {
            return nextField(from: source, in: container) != nil
        }
        
        /// Indicates if a preceding `UITextInputView` from the provided view exists.
        ///
        /// - Parameters:
        ///   - source: `UITextInputView` to find the previous field from
        ///   - container: Optional form container. If nil, the top-level container of the source will be determined and used.
        /// - Returns: True if there is a previous field. Otherwise false.
        public static func hasPreviousField(from source: UITextInputView, in container: UIView?) -> Bool {
            return previousField(from: source, in: container) != nil
        }
        
        private static func sortedFields(around source: UITextInputView, in container: UIView?) -> [UITextInputView] {
            let container = container ?? source.topLevelContainer
            return container.textInputViews.sortedByPosition(in: container)
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
    
    /// Containing view of text inputs that can be navigated by the AutoNavigator instance
    private var containerView: UIView

    /// Delegate that will be informed of navigation tap events
    weak open var delegate: KeyboardAutoNavigatorDelegate?
    
    // MARK: - Init
    /// Initializes a `KeyboardAutoNavigator`
    ///
    /// - Parameters:
    ///   - containerView: Containing view of text inputs that can be navigated by the AutoNavigator instance
    ///   - defaultToolbar: Default toolbar to be populated on a textInput when editing begins. If that input implements `KeyboardToolbarProviding` that input's toolbar will be used instead.
    ///   - returnKeyNavigationEnabled: If enabled, the auto navigator will add itself as a target to a `UITextField`'s textFieldEditingDidEndOnExit action and advance to the next field when the return key is tapped.
    public init(containerView: UIView, defaultToolbar: NavigatingKeyboardAccessoryView? = nil, returnKeyNavigationEnabled: Bool = true) {
        self.containerView = containerView
        
        super.init(keyboardToolbar: defaultToolbar, returnKeyNavigationEnabled: returnKeyNavigationEnabled)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textEditingDidBegin(_:)), name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textEditingDidBegin(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidBeginEditingNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidBeginEditingNotification, object: nil)
    }
    
    public func refreshCurrentToolbarButtonStates() {
        guard let currentTextInput = currentTextInputView,
            let currentToolbar = currentTextInputView?.inputAccessoryView as? NavigatingKeyboardAccessory else { return }
        
        let hasNext = AutoPilot.hasNextField(from: currentTextInput, in: containerView)
        let hasPrevious = AutoPilot.hasPreviousField(from: currentTextInput, in: containerView)
        
        if !hasNext && !hasPrevious {
            currentToolbar.setNextAndBackButtonsHidden(true)
        } else {
            currentToolbar.setNextAndBackButtonsHidden(false)
            
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
            inputView.isDescendant(of: containerView) else { return }
        currentTextInputView = inputView
        
        if returnKeyNavigationEnabled, let controlInput = currentTextInputView as? UIControl {
            controlInput.addTarget(self, action: #selector(textFieldEditingDidEndOnExit(_:)), for: UIControl.Event.editingDidEndOnExit)
        }
        
        applyToolbarToTextInput(inputView)
        
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
            AutoPilot.nextField(from: sender, in: containerView)?.becomeFirstResponder()
        }
    }
}

// MARK: - Helpers
extension KeyboardAutoNavigator {
    private func applyToolbarToTextInput(_ textInput: UITextInputView) {
        let toolbar = (textInput as? KeyboardToolbarProviding)?.keyboardToolbar ?? keyboardToolbar
        toolbar?.keyboardAccessoryDelegate = self

        if let textInput = textInput as? UITextField {
            textInput.inputAccessoryView = toolbar
        } else if let textInput = textInput as? UITextView {
            textInput.inputAccessoryView = toolbar
            
            // UITextView does not display its toolbar if it's set via a textDidBeginEditingNotification handler. Force a reload of the input views to make it display.
            textInput.reloadInputViews()
        }
    }
}

// MARK: - KeyboardAccessoryDelegate
extension KeyboardAutoNavigator: KeyboardAccessoryDelegate {
    private func didTapBack() {
        defer {
            delegate?.keyboardAutoNavigatorDidTapBack(self)
        }
        
        guard let currentTextField = currentTextInputView else { return }
        AutoPilot.previousField(from: currentTextField, in: containerView)?.becomeFirstResponder()
    }
    
    private func didTapNext() {
        defer {
            delegate?.keyboardAutoNavigatorDidTapNext(self)
        }
        
        guard let currentTextField = currentTextInputView else { return }
        AutoPilot.nextField(from: currentTextField, in: containerView)?.becomeFirstResponder()
    }
    
    private func didTapDone() {
        currentTextInputView?.resignFirstResponder()
        delegate?.keyboardAutoNavigatorDidTapDone(self)
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
