//
//  ViewControllerA.swift
//  KeyboardSupport_Example
//
//  Copyright (c) 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import KeyboardSupport

/// Demonstrates using a custom input accessory view and using the keyboard's return keys.
class ViewControllerA: KeyboardSupportViewController {
    
    // MARK: - Properties
    
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!
    @IBOutlet private var textField3: UITextField!
    @IBOutlet private var textField4: UITextField!
    @IBOutlet private var textField5: UITextField!
    @IBOutlet private var textField6: UITextField!
    @IBOutlet private var textField7: UITextField!
    @IBOutlet private var textField8: UITextField!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFields: [UITextField] = [textField1, textField2, textField3, textField4, textField5, textField6, textField7, textField8]
        let keyboardToolbar = KeyboardToolbar()
        let configuration = KeyboardSupportConfiguration(textFields: textFields, scrollView: scrollView, keyboardInputAccessoryView: keyboardToolbar)
        configureKeyboardSupport(with: configuration)
        keyboardSupportDelegate = self
    }
}

// MARK: - KeyboardSupportDelegate
extension ViewControllerA: KeyboardSupportDelegate {
    
    func didTapDoneButton() {
        // Execute code for "Done" button tap such as validation or login.
        print("Done button tapped")
    }
}
