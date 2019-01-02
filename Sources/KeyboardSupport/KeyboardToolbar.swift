//
//  KeyboardToolbar.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 7/28/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

/// AutoNavigator will ask a TextInputView that conforms to this protocol for a toolbar to use in place of the default toolbar.
/// If this variable is nil, the defualt toolbar will not be used.
protocol KeyboardToolbarProviding {
    var keyboardToolbar: KeyboardToolbar? { get }
}

/// An object that displays a toolbar above the keyboard.
open class KeyboardToolbar: UIToolbar, KeyboardAccessory {
    
    // MARK: - KeyboardAccessory
    
    open weak var keyboardAccessoryDelegate: KeyboardAccessoryDelegate?
    open var nextButton: UIBarButtonItem?
    open var backButton: UIBarButtonItem?
    open var doneButton: UIBarButtonItem?
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        var aFrame = frame
        if aFrame == .zero {
            aFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        }
        
        super.init(frame: aFrame)
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
    
    /// Adds a `UIBarButtonItem` set with a title for backward navigation.
    open func addBackButton(title: String) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton = button
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with images for backward navigation.
    open func addBackButton(image: UIImage, landscapeImagePhone: UIImage? = nil, width: CGFloat? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: #selector(backButtonTapped))
        width.flatMap { button.width = $0 }
        backButton = button
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with a title for forward navigation.
    open func addNextButton(title: String) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(nextButtonTapped))
        nextButton = button
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with images for forward navigation.
    open func addNextButton(image: UIImage, landscapeImagePhone: UIImage? = nil, width: CGFloat? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: #selector(nextButtonTapped))
        width.flatMap { button.width = $0 }
        nextButton = button
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with a title for ending navigation.
    open func addDoneButton(title: String) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(doneButtonTapped))
        doneButton = button
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with images for ending navigation.
    open func addDoneButton(image: UIImage, landscapeImagePhone: UIImage? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: #selector(doneButtonTapped))
        doneButton = button
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

// MARK: - methods for hiding next and back buttons
public extension KeyboardToolbar {
    public func setNextAndBackButtonsHidden(hidden: Bool) {
        if hidden {
            removeNextButton()
            removeBackButton()
        } else {
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
    
    @objc public func backButtonTapped(_ sender: UIBarButtonItem) {
        keyboardAccessoryDelegate?.keyboardAccessoryDidTapBack(self)
    }
    
    @objc public func nextButtonTapped(_ sender: UIBarButtonItem) {
        keyboardAccessoryDelegate?.keyboardAccessoryDidTapNext(self)
    }
    
    @objc public func doneButtonTapped(_ sender: UIBarButtonItem) {
        keyboardAccessoryDelegate?.keyboardAccessoryDidTapDone(self)
    }
}
