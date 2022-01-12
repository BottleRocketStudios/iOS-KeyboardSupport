//
//  KeyboardNavigatorTests.swift
//  Tests
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
        // Arrange
        let keyboardNavigator = keyboardNavigatorWithTextFields()
        
        // Assert
        XCTAssertEqual(keyboardNavigator.textInputs.count, 3)
        XCTAssertTrue(keyboardNavigator.keyboardToolbar === keyboardToolbar)
        XCTAssertTrue(keyboardNavigator.returnKeyNavigationEnabled)
        XCTAssertEqual(keyboardNavigator.currentTextInputIndex, 0)
    }
    
    func test_KeyboardNavigator_InitializesWithTextViews() {
        // Arrange
        let keyboardNavigator = keyboardNavigatorWithTextViews()
        
        // Assert
        XCTAssertEqual(keyboardNavigator.textInputs.count, 3)
        XCTAssertTrue(keyboardNavigator.keyboardToolbar === keyboardToolbar)
        XCTAssertTrue(keyboardNavigator.returnKeyNavigationEnabled)
        XCTAssertEqual(keyboardNavigator.currentTextInputIndex, 0)
    }
    
    func test_KeyboardNavigatorWithTextFields_AccessoryDidTapBack() {
        // Arrange
        let textFieldNavigator = keyboardNavigatorWithTextFields()
        let mockDelegate = MockKeyboardNavigatorDelegate()
        textFieldNavigator.delegate = mockDelegate
        
        // Act
        textFieldNavigator.keyboardAccessoryDidTapNext(UIView())
        textFieldNavigator.keyboardAccessoryDidTapBack(UIView())
        
        // Assert
        XCTAssertEqual(textFieldNavigator.currentTextInputIndex, 0)
        XCTAssertEqual(mockDelegate.tapType, TapType.back)
    }
    
    func test_KeyboardNavigatorWithTextViews_AccessoryDidTapBack() {
        // Arrange
        let textViewNavigator = keyboardNavigatorWithTextViews()
        let mockDelegate = MockKeyboardNavigatorDelegate()
        textViewNavigator.delegate = mockDelegate
        
        // Act
        textViewNavigator.keyboardAccessoryDidTapNext(UIView())
        textViewNavigator.keyboardAccessoryDidTapBack(UIView())
        
        // Assert
        XCTAssertEqual(textViewNavigator.currentTextInputIndex, 0)
        XCTAssertEqual(mockDelegate.tapType, TapType.back)
    }
    
    func test_KeyboardNavigatorWithTextFields_AccessoryDidTapNext() {
        // Arrange
        let textFieldNavigator = keyboardNavigatorWithTextFields()
        let mockDelegate = MockKeyboardNavigatorDelegate()
        textFieldNavigator.delegate = mockDelegate
        
        // Act
        textFieldNavigator.keyboardAccessoryDidTapNext(UIView())
        
        // Assert
        XCTAssertEqual(textFieldNavigator.currentTextInputIndex, 1)
        XCTAssertEqual(mockDelegate.tapType, TapType.next)
    }
    
    func test_KeyboardNavigatorWithTextViews_AccessoryDidTapNext() {
        // Arrange
        let textViewNavigator = keyboardNavigatorWithTextViews()
        let mockDelegate = MockKeyboardNavigatorDelegate()
        textViewNavigator.delegate = mockDelegate
        
        // Act
        textViewNavigator.keyboardAccessoryDidTapNext(UIView())
        
        // Assert
        XCTAssertEqual(textViewNavigator.currentTextInputIndex, 1)
        XCTAssertEqual(mockDelegate.tapType, TapType.next)
    }
    
    func test_KeyboardNavigatorWithTextFields_AccessoryDidTapDone() {
        // Arrange
        let textFieldNavigator = keyboardNavigatorWithTextFields()
        let mockDelegate = MockKeyboardNavigatorDelegate()
        textFieldNavigator.delegate = mockDelegate
        
        // Act
        textFieldNavigator.keyboardAccessoryDidTapDone(UIView())
        
        // Assert
        XCTAssertEqual(mockDelegate.tapType, TapType.done)
    }
    
    func test_KeyboardNavigatorWithTextViews_AccessoryDidTapDone() {
        // Arrange
        let textViewNavigator = keyboardNavigatorWithTextViews()
        let mockDelegate = MockKeyboardNavigatorDelegate()
        textViewNavigator.delegate = mockDelegate
        
        // Act
        textViewNavigator.keyboardAccessoryDidTapDone(UIView())
        
        // Assert
        XCTAssertEqual(mockDelegate.tapType, TapType.done)
    }
}

// MARK: - KeyboardNavigator Initialization Helpers

private extension KeyboardNavigatorTests {
    
    func keyboardNavigatorWithTextFields() -> KeyboardNavigator {
        let textInput1 = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let textInput2 = UITextField(frame: CGRect(x: 0, y: 100, width: 100, height: 50))
        let textInput3 = UITextField(frame: CGRect(x: 0, y: 200, width: 100, height: 50))
        let keyboardNavigator = KeyboardNavigator(textInputs: [textInput1, textInput2, textInput3], keyboardToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
        
        return keyboardNavigator
    }
    
    func keyboardNavigatorWithTextViews() -> KeyboardNavigator {
        let textInput1 = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let textInput2 = UITextView(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        let textInput3 = UITextView(frame: CGRect(x: 0, y: 200, width: 100, height: 100))
        let keyboardNavigator = KeyboardNavigator(textInputs: [textInput1, textInput2, textInput3], keyboardToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
        
        return keyboardNavigator
    }
}
