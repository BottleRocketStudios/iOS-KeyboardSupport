//
//  KeyboardToolbar.swift
//  KeyboardSupport_Example
//
//  Created by Earl Gaspard on 12/19/17.
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import KeyboardSupport

/// A custom keyboard toolbar.
class KeyboardToolbar: UIToolbar, KeyboardInputAccessory {

    // MARK: - Properties
    
    private var buttonItems: [UIBarButtonItem] = []
    weak var keyboardInputAccessoryDelegate: KeyboardInputAccessoryDelegate?
    
    // MARK: - Init
    
    override public init(frame: CGRect) {
        var aFrame = frame
        if aFrame == .zero {
            aFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        }
        
        super.init(frame: aFrame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
}

// MARK: - Private

private extension KeyboardToolbar {
    
    // MARK: - Configure
    
    func configure() {
        addButton(title: "Back", action: #selector(backButtonTapped))
        addButton(title: "Next", action: #selector(nextButtonTapped))
        addFlexibleSpace()
        addDoneButton()
        
        items = buttonItems
    }
    
    // MARK: - Actions
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        keyboardInputAccessoryDelegate?.keyboardInputAccessoryDidTapBack(self)
    }
    
    @objc func nextButtonTapped(_ sender: UIBarButtonItem) {
        keyboardInputAccessoryDelegate?.keyboardInputAccessoryDidTapNext(self)
    }
    
    @objc func doneButtonTapped(_ sender: UIBarButtonItem) {
        keyboardInputAccessoryDelegate?.keyboardInputAccessoryDidTapDone(self)
    }
    
    // MARK: - Methods
    
    func addButton(title: String, action: Selector?) {
        let button = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        buttonItems.append(button)
    }
    
    func addDoneButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        buttonItems.append(button)
    }
    
    func addFlexibleSpace() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        buttonItems.append(flexibleSpace)
    }
}
