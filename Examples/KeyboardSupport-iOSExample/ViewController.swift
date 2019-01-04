//
//  ViewController.swift
//  KeyboardSupport-iOSExample
//
//  Created by Earl Gaspard on 7/30/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit
import KeyboardSupport

class ViewController: UIViewController, KeyboardRespondable {

    // IBOutlets
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var textField1: UITextField!
    @IBOutlet private var textField2: UITextField!
    @IBOutlet private var textField3: UITextField!
    @IBOutlet private var textView: UITextView!
    
    // KeyboardScrollable
    var keyboardScrollableScrollView: UIScrollView? {
        return scrollView
    }
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // KeyboardNavigator
    private var keyboardNavigator: KeyboardNavigator?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // KeyboardDismissable setup
        setupKeyboardDismissalView()
        
        // KeyboardToolbar setup
        let keyboardToolbar = KeyboardToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        keyboardToolbar.addButton(type: .back, title: "Back")
        keyboardToolbar.addButton(type: .next, title: "Next")
        keyboardToolbar.addFlexibleSpace()
        keyboardToolbar.addSystemDoneButton()
        
        // KeyboardNavigator setup
        keyboardNavigator = KeyboardNavigator(textInputs: [textField1, textField2, textView, textField3], keyboardToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
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
    
    // MARK: - KeyboardScrollable
    
    func keyboardWillShow(keyboardInfo: KeyboardInfo) {
        // Implement any custom animations or code you want to run alongside the appearance of the keyboard
        print("keyboardWillShow")
    }
    
    func keyboardWillHide(keyboardInfo: KeyboardInfo) {
        // Implement any custom animations or code you want to run alongside the disappearance of the keyboard
        print("keyboardWillHide")
    }
}

// MARK: - KeyboardNavigatorDelegate

extension ViewController: KeyboardNavigatorDelegate {
    
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
