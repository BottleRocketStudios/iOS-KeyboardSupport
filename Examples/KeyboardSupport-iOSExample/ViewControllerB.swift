//
//  ViewControllerB.swift
//  KeyboardSupport_Example
//
//  Created by Earl Gaspard on 12/19/17.
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import KeyboardSupport

/// Demonstrates using KeyboardManager without an input accessory view while still using the keyboard's return keys.
class ViewControllerB: UIViewController {

    // MARK: - Properties
    
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!
    private var keyboardManager: KeyboardManager?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Conforms to UITextFieldDelegate to show your view controller can get text field callbacks.
        textField1.delegate = self
        
        // KeyboardManager setup
        keyboardManager = KeyboardManager(textFields: [textField1, textField2], returnKeyNavigationEnabled: true)
        keyboardManager?.delegate = self
    }
}

// MARK: - KeyboardManagerDelegate
extension ViewControllerB: KeyboardManagerDelegate {
    
    func keyboardManagerDidTapDone(_ manager: KeyboardManager) {
        debugPrint("Done was tapped in ViewControllerB.")
    }
}

// MARK: - UITextFieldDelegate
extension ViewControllerB: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        debugPrint("textField1 did begin editing")
    }
}
