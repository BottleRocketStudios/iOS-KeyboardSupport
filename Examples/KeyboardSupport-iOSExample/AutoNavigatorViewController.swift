//
//  AutoNavigatorViewController.swift
//  KeyboardSupport
//
//  Created by John Davis on 12/18/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit
import KeyboardSupport

/// The `AutoNavigatorViewController` demonstates the configuration and use of a  `KeyboardAutoNavigator` instance. It is noteworthy that the `KeyboardAutoNavigator` will disable and enable the next back buttons in a `NavigatingKeyboardAccessory` when no previous or next input field is available for navigation.

class AutoNavigatorViewController: UIViewController, KeyboardRespondable {

    // IBOutlets
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private(set) var textField1: UITextField!
    @IBOutlet private(set) var textField2: UITextField!
    @IBOutlet private(set) var textField3: UITextField!
    @IBOutlet private(set) var textView: UITextView!
    
    // KeyboardScrollable
    var keyboardScrollableScrollView: UIScrollView? {
        return scrollView
    }
    
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // KeyboardNavigator
    private var keyboardNavigator: KeyboardAutoNavigator?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // KeyboardDismissable setup
        setupKeyboardDismissalView()
        
        // KeyboardToolbar setup
        let keyboardToolbar = KeyboardToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44.0))
        keyboardToolbar.addButton(type: .back, title: "Back")
        keyboardToolbar.addButton(type: .next, title: "Next")
        keyboardToolbar.addFlexibleSpace()
        keyboardToolbar.addSystemDoneButton()
        
        // KeyboardNavigator setup
        keyboardNavigator = KeyboardAutoNavigator(containerView: scrollView, defaultToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
        keyboardNavigator?.delegate = self
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

// MARK: - KeyboardAutoNavigatorDelegate

extension AutoNavigatorViewController: KeyboardAutoNavigatorDelegate {
    
    func keyboardAutoNavigatorDidTapBack(_ navigator: KeyboardAutoNavigator) {
        print("keyboardAutoNavigatorDidTapBack")
    }
    
    func keyboardAutoNavigatorDidTapNext(_ navigator: KeyboardAutoNavigator) {
        print("keyboardAutoNavigatorDidTapNext")
    }
    
    func keyboardAutoNavigatorDidTapDone(_ navigator: KeyboardAutoNavigator) {
        print("keyboardAutoNavigatorDidTapDone")
    }
}
