//
//  KeyboardToolbar.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 7/28/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

/// Represents a navigation type that a button could have on `KeyboardToolbar`.
public enum KeyboardToolbarButtonNavigationType {
    case back
    case next
    case done
    
    var action: Selector {
        switch self {
        case .back:
            return #selector(KeyboardToolbar.backButtonTapped)
        case .next:
            return #selector(KeyboardToolbar.nextButtonTapped)
        case .done:
            return #selector(KeyboardToolbar.doneButtonTapped)
        }
    }
}

/// Represents a toolbar shown above the keyboard.
open class KeyboardToolbar: UIToolbar, KeyboardAccessory {
    
    // MARK: - KeyboardAccessory
    
    open weak var keyboardAccessoryDelegate: KeyboardAccessoryDelegate?
    
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
    open func addButton(type: KeyboardToolbarButtonNavigationType, title: String) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: type.action)
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` with images for a `KeyboardToolbarButtonNavigationType`.
    open func addButton(type: KeyboardToolbarButtonNavigationType, image: UIImage, landscapeImagePhone: UIImage? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: type.action)
        items?.append(button)
    }

    /// Adds a `UIBarButtonItem` set to the system item of `.done` for ending navigation.
    open func addSystemDoneButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` to the toolbar to show blank space between items.
    open func addFlexibleSpace() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        items?.append(flexibleSpace)
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
