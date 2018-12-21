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
        setupKeyboardObservers()
        
        // KeyboardToolbar setup
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addBackButton(title: "Back")
        keyboardToolbar.addNextButton(title: "Next")
        keyboardToolbar.addFlexibleSpace()
        keyboardToolbar.addSystemDoneButton()
        
        // KeyboardNavigator setup
        keyboardNavigator = KeyboardAutoNavigator(navigationContainer: scrollView, defaultToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
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

extension AutoNavigatorViewController: KeyboardNavigatorDelegate {
    
    func keyboardNavigatorDidTapBack(_ navigator: KeyboardNavigator) {
        print("keyboardNavigatorDidTapBack")
    }
    
    func keyboardNavigatorDidTapNext(_ navigator: KeyboardNavigator) {
        print("keyboardNavigatorDidTapNext")
    }
    
    func keyboardNavigatorDidTapDone(_ navigator: KeyboardNavigator) {
        print("keyboardNavigatorDidTapDone")
    }
}
