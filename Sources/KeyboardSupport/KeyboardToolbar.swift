//
//  KeyboardToolbar.swift
//  KeyboardExample
//
//  Created by Earl Gaspard on 7/28/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

/// An object that displays a toolbar above the keyboard.
open class KeyboardToolbar: UIToolbar, KeyboardAccessory {
    
    // MARK: - KeyboardAccessory
    
    open weak var keyboardAccessoryDelegate: KeyboardAccessoryDelegate?
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        var aFrame = frame
        if aFrame == .zero {
            aFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
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

private extension KeyboardToolbar {
    
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
