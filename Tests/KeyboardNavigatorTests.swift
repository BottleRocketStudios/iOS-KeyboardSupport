//
//  KeyboardNavigatorTests.swift
//  KeyboardSupport-iOSTests
//
//  Created by Earl Gaspard on 8/3/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import XCTest
@testable import KeyboardSupport

class KeyboardNavigatorTests: XCTestCase {

    // MARK: - Properties
    
    private let keyboardToolbar = KeyboardToolbar()
    
    // MARK: - Tests
    
    func test_KeyboardNavigator_InitializesWithTextFields() {
        let keyboardNavigator = keyboardNavigatorWithTextFields()
        
        XCTAssertEqual(keyboardNavigator.textInputs.count, 3)
        XCTAssertEqual(keyboardNavigator.keyboardToolbar, keyboardToolbar)
        XCTAssertTrue(keyboardNavigator.returnKeyNavigationEnabled)
        XCTAssertEqual(keyboardNavigator.currentTextInputIndex, 0)
    }
    
    func test_KeyboardNavigator_InitializesWithTextViews() {
        let keyboardNavigator = keyboardNavigatorWithTextViews()
        
        XCTAssertEqual(keyboardNavigator.textInputs.count, 3)
        XCTAssertEqual(keyboardNavigator.keyboardToolbar, keyboardToolbar)
        XCTAssertTrue(keyboardNavigator.returnKeyNavigationEnabled)
        XCTAssertEqual(keyboardNavigator.currentTextInputIndex, 0)
    }
    
    func test_KeyboardNavigator_AccessoryDidTapBack() {
        let textFieldNavigator = keyboardNavigatorWithTextFields()
        textFieldNavigator.keyboardAccessoryDidTapNext(UIView())
        textFieldNavigator.keyboardAccessoryDidTapBack(UIView())
        
        let textViewNavigator = keyboardNavigatorWithTextViews()
        textViewNavigator.keyboardAccessoryDidTapNext(UIView())
        textViewNavigator.keyboardAccessoryDidTapBack(UIView())
    }
    
    func test_KeyboardNavigator_AccessoryDidTapNext() {
        let textFieldNavigator = keyboardNavigatorWithTextFields()
        textFieldNavigator.keyboardAccessoryDidTapNext(UIView())
        
        let textViewNavigator = keyboardNavigatorWithTextViews()
        textViewNavigator.keyboardAccessoryDidTapNext(UIView())
    }
    
    func test_KeyboardNavigator_AccessoryDidTapDone() {
        let textFieldNavigator = keyboardNavigatorWithTextFields()
        textFieldNavigator.keyboardAccessoryDidTapDone(UIView())
        
        let textViewNavigator = keyboardNavigatorWithTextViews()
        textViewNavigator.keyboardAccessoryDidTapDone(UIView())
    }
}

extension KeyboardNavigatorTests: KeyboardNavigatorDelegate {
    
    func keyboardNavigatorDidTapBack(_ navigator: KeyboardNavigator) {
        XCTAssertEqual(navigator.textInputs.count, 3)
        XCTAssertEqual(navigator.keyboardToolbar, keyboardToolbar)
        XCTAssertTrue(navigator.returnKeyNavigationEnabled)
        XCTAssertEqual(navigator.currentTextInputIndex, 0)
    }
    
    func keyboardNavigatorDidTapNext(_ navigator: KeyboardNavigator) {
        XCTAssertEqual(navigator.textInputs.count, 3)
        XCTAssertEqual(navigator.keyboardToolbar, keyboardToolbar)
        XCTAssertTrue(navigator.returnKeyNavigationEnabled)
        XCTAssertEqual(navigator.currentTextInputIndex, 1)
    }
    
    func keyboardNavigatorDidTapDone(_ navigator: KeyboardNavigator) {
        XCTAssertEqual(navigator.textInputs.count, 3)
        XCTAssertEqual(navigator.keyboardToolbar, keyboardToolbar)
        XCTAssertTrue(navigator.returnKeyNavigationEnabled)
        XCTAssertEqual(navigator.currentTextInputIndex, 0)
    }
}

private extension KeyboardNavigatorTests {
    
    func keyboardNavigatorWithTextFields() -> KeyboardNavigator {
        let textInput1 = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let textInput2 = UITextField(frame: CGRect(x: 0, y: 100, width: 100, height: 50))
        let textInput3 = UITextField(frame: CGRect(x: 0, y: 200, width: 100, height: 50))
        let keyboardNavigator = KeyboardNavigator(textInputs: [textInput1, textInput2, textInput3], keyboardToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
        keyboardNavigator.delegate = self
        
        return keyboardNavigator
    }
    
    func keyboardNavigatorWithTextViews() -> KeyboardNavigator {
        let textInput1 = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let textInput2 = UITextView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        let textInput3 = UITextView(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        let keyboardNavigator = KeyboardNavigator(textInputs: [textInput1, textInput2, textInput3], keyboardToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
        keyboardNavigator.delegate = self
        
        return keyboardNavigator
    }
}
