//
//  ViewControllerA.swift
//  KeyboardSupport_Example
//
//  Copyright (c) 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import KeyboardSupport

/// Demonstrates using KeyboardManager with a custom input accessory view while not using the keyboard's return keys.
/// Conforms to KeyboardRespondable to allow for dismissing the keyboard by tapping outside a text field and for adjusting scrolling in a UIScrollView.
class ViewControllerA: UIViewController, KeyboardRespondable {
    
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
    private var keyboardManager: KeyboardManager?
    
    // MARK: - KeyboardRespondable
    
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardScrollableScrollView = scrollView
        setupKeyboardRespondable()
        
        // KeyboardManager setup
        let keyboardToolbar = KeyboardToolbar()
        keyboardManager = KeyboardManager(textFields: [textField1, textField2, textField3, textField4, textField5, textField6, textField7, textField8], inputAccessoryView: keyboardToolbar, returnKeyNavigationEnabled: false)
        keyboardManager?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}

// MARK: - KeyboardManagerDelegate

extension ViewControllerA: KeyboardManagerDelegate {
    
    func keyboardManagerDidTapDone(_ manager: KeyboardManager) {
        print("Done was tapped in ViewControllerA.")
    }
}
