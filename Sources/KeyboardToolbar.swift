//
//  KeyboardToolbar.swift
//  KeyboardSupport
//
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

/// AutoNavigator will ask a TextInputView that conforms to this protocol for a toolbar to use in place of the default toolbar.
/// If this variable is nil, the default toolbar of the KeyboardAutoNavigator will be used.
protocol KeyboardToolbarProviding {
    var keyboardToolbar: KeyboardAccessoryView? { get }
}

/// An object that displays a toolbar above the keyboard.
open class KeyboardToolbar: UIToolbar, NavigatingKeyboardAccessory {
    
    // MARK: - Sub-types
    
    public enum ButtonNavigationType {
        case back
        case next
        case done
        
        var action: Selector {
            switch self {
            case .back:
                return #selector(backButtonTapped)
            case .next:
                return #selector(nextButtonTapped)
            case .done:
                return #selector(doneButtonTapped)
            }
        }
    }
    
    // MARK: - KeyboardAccessory
    
    open weak var keyboardAccessoryDelegate: KeyboardAccessoryDelegate?
    open var nextButton: UIBarButtonItem?
    open var backButton: UIBarButtonItem?
    open var doneButton: UIBarButtonItem?
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        items = []
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        items = []
    }
    
    // MARK: - Configuring Buttons
    
    /// Adds a `UIBarButtonItem` to the toolbar.
    open func addButton(_ button: UIBarButtonItem) {
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` with a title for a `KeyboardToolbarButtonNavigationType`.
    open func addButton(type: ButtonNavigationType, title: String, width: CGFloat? = nil) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: type.action)
        width.flatMap { button.width = $0 }
        storeButton(button, ofType: type)
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` with images for a `KeyboardToolbarButtonNavigationType`.
    open func addButton(type: ButtonNavigationType, image: UIImage, landscapeImagePhone: UIImage? = nil, width: CGFloat? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: type.action)
        width.flatMap { button.width = $0 }
        storeButton(button, ofType: type)
        items?.append(button)
    }

    /// Adds a `UIBarButtonItem` set to the system item of `.done` for ending navigation.
    open func addSystemDoneButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        doneButton = button
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` to the toolbar to show blank space between items.
    open func addFlexibleSpace() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        items?.append(flexibleSpace)
    }
}

// MARK: - Private helpers
private extension KeyboardToolbar {
    private func storeButton(_ button: UIBarButtonItem, ofType type: ButtonNavigationType) {
        switch type {
        case .back:
            backButton = button
        case .next:
            nextButton = button
        case .done:
            doneButton = button
        }
    }
}

// MARK: - methods for hiding next and back buttons
public extension KeyboardToolbar {
    func setNextAndBackButtonsHidden(_ hidden: Bool) {
        if hidden {
            removeNextButton()
            removeBackButton()
        } else {
            replaceNextAndBackButtons()
        }
    }
    
    private func replaceNextAndBackButtons() {
        let currentNextButtonIndex = nextButton.flatMap { items?.firstIndex(of: $0) }
        let currentBackButtonIndex = backButton.flatMap { items?.firstIndex(of: $0) }
        
        // If either button is not present, clean them out, and replace them.
        if currentBackButtonIndex == nil || currentNextButtonIndex == nil {
            removeBackButton()
            removeNextButton()
            
            nextButton.flatMap { items?.insert($0, at: 0) }
            backButton.flatMap { items?.insert($0, at: 0) }
        }
    }
    
    private func removeNextButton() {
        guard let nextButton = nextButton, let nextButtonIndex = items?.firstIndex(of: nextButton) else { return }
        items?.remove(at: nextButtonIndex)
    }
    
    private func removeBackButton() {
        guard let backButton = backButton, let backButtonIndex = items?.firstIndex(of: backButton) else { return }
        items?.remove(at: backButtonIndex)
    }
}

public extension KeyboardToolbar {
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        keyboardAccessoryDelegate?.keyboardAccessoryDidTapBack(self)
    }
    
    @objc func nextButtonTapped(_ sender: UIBarButtonItem) {
        keyboardAccessoryDelegate?.keyboardAccessoryDidTapNext(self)
    }
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        keyboardAccessoryDelegate?.keyboardAccessoryDidTapDone(self)
    }
}
