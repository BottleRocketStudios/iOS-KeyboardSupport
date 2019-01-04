//
//  KeyboardToolbar.swift
//  KeyboardSupport
//
//  Created by Earl Gaspard on 7/28/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

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
    
    /// Adds a `UIBarButtonItem` set with a title for backward navigation.
    open func addBackButton(title: String) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(backButtonTapped))
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with images for backward navigation.
    open func addBackButton(image: UIImage, landscapeImagePhone: UIImage? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: #selector(backButtonTapped))
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with a title for forward navigation.
    open func addNextButton(title: String) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(nextButtonTapped))
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with images for forward navigation.
    open func addNextButton(image: UIImage, landscapeImagePhone: UIImage? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: #selector(nextButtonTapped))
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with a title for ending navigation.
    open func addDoneButton(title: String) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(doneButtonTapped))
        items?.append(button)
    }
    
    /// Adds a `UIBarButtonItem` set with images for ending navigation.
    open func addDoneButton(image: UIImage, landscapeImagePhone: UIImage? = nil) {
        let button = UIBarButtonItem(image: image, landscapeImagePhone: landscapeImagePhone, style: .plain, target: self, action: #selector(doneButtonTapped))
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
