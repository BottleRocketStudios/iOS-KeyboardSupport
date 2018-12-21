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
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // KeyboardNavigator
    private var keyboardNavigator: KeyboardNavigator?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        
        // KeyboardDismissable setup
        setupKeyboardDismissalView()
        
        // KeyboardScrollable setup
        keyboardScrollableScrollView = scrollView
        setupKeyboardObservers()
        
        // KeyboardToolbar setup
        let keyboardToolbar = KeyboardToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        keyboardToolbar.addBackButton(title: "Back")
        keyboardToolbar.addNextButton(title: "Next")
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
    
    func keyboardWillShow() {
        print("keyboardWillShow")
    }
    
    func keyboardWillHide() {
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

// MARK: - UITextViewDelegate

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        // Setting the currentTextInputIndex here allows the KeyboardNavigator to move to textView when provided with a KeyboardToolbar that supports 'Back' or 'Next' taps.
        // The currentTextInputIndex needs to be set to the textView's position in the textInputs passed into KeyboardNavigator. In this example it is 2 because textView is 3rd element in the array.
        keyboardNavigator?.currentTextInputIndex = 2
    }
}