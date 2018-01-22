//
//  KeyboardSupportConfigurationTests.swift
//  KeyboardSupport_Tests
//
//  Copyright © 2018 Bottle Rocket Studios. All rights reserved.
//

import XCTest
import KeyboardSupport

class KeyboardSupportConfigurationTests: XCTestCase {
    
    class MockKeyboardToolbar: UIToolbar, KeyboardInputAccessory {
        var keyboardInputAccessoryDelegate: KeyboardInputAccessoryDelegate?
    }
    
    func test_Configuration_InitializesWithDefaultValues() {
        let configuration = KeyboardSupportConfiguration()
        
        XCTAssertEqual(configuration.textFields, [])
        XCTAssertNil(configuration.scrollView)
        XCTAssertNil(configuration.bottomConstraint)
        XCTAssertEqual(configuration.constraintOffset, 0)
        XCTAssertFalse(configuration.usesDismissalView)
        XCTAssertFalse(configuration.usesKeyboardNextButtons)
        XCTAssertNil(configuration.keyboardInputAccessoryView)
    }
    
    func test_Configuration_InitializesWithCustomValues() {
        let textFields = [UITextField(), UITextField()]
        let scrollView = UIScrollView()
        let bottomConstraint = NSLayoutConstraint()
        let constraintOffest: CGFloat = 44
        let usesDismissalView = true
        let usesKeyboardNextButtons = true
        let keyboardInputAccessoryView = MockKeyboardToolbar()
        let configuration = KeyboardSupportConfiguration(textFields: textFields, scrollView: scrollView, bottomConstraint: bottomConstraint, constraintOffset: constraintOffest, usesDismissalView: usesDismissalView, usesKeyboardNextButtons: usesKeyboardNextButtons, keyboardInputAccessoryView: keyboardInputAccessoryView)
        
        XCTAssertEqual(configuration.textFields, textFields)
        XCTAssertEqual(configuration.scrollView, scrollView)
        XCTAssertEqual(configuration.bottomConstraint, bottomConstraint)
        XCTAssertEqual(configuration.constraintOffset, constraintOffest)
        XCTAssertTrue(configuration.usesDismissalView)
        XCTAssertTrue(configuration.usesKeyboardNextButtons)
        XCTAssertEqual(configuration.keyboardInputAccessoryView, keyboardInputAccessoryView)
    }
}
