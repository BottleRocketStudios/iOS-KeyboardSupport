//
//  AutoNavigatorViewController.swift
//  KeyboardSupport
//
//  Created by John Davis on 12/18/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit
import KeyboardSupport

class AutoNavigatorViewController: UIViewController, KeyboardRespondable {

    // IBOutlets
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private(set) var textField1: UITextField!
    @IBOutlet private(set) var textField2: UITextField!
    @IBOutlet private(set) var textField3: UITextField!
    @IBOutlet private(set) var textView: UITextView!
    
    // KeyboardScrollable
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // KeyboardNavigator
    private(set) var keyboardNavigator: KeyboardAutoNavigator?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // KeyboardDismissable setup
        setupKeyboardDismissalView()
        
        // KeyboardScrollable setup
        keyboardScrollableScrollView = scrollView
        
        // KeyboardToolbar setup
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addButton(type: .back, title: "Back")
        keyboardToolbar.addButton(type: .next, title: "Next")
        keyboardToolbar.addFlexibleSpace()
        keyboardToolbar.addSystemDoneButton()
        
        // KeyboardNavigator setup
        keyboardNavigator = KeyboardAutoNavigator(navigationContainer: scrollView, defaultToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
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

// MARK: - KeyboardNavigatorDelegate

extension AutoNavigatorViewController: KeyboardAutoNavigatorDelegate {
    
    func keyboardNavigatorDidTapBack(_ navigator: KeyboardAutoNavigator) {
        print("keyboardNavigatorDidTapBack")
    }
    
    func keyboardNavigatorDidTapNext(_ navigator: KeyboardAutoNavigator) {
        print("keyboardNavigatorDidTapNext")
    }
    
    func keyboardNavigatorDidTapDone(_ navigator: KeyboardAutoNavigator) {
        print("keyboardNavigatorDidTapDone")
    }
}
