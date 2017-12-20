//
//  KeyboardSupportTests.swift
//  KeyboardSupport_Tests
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import XCTest
import KeyboardSupport

/// A mock view for testing.
class MockAccessoryView: UIView, KeyboardInputAccessory {
    weak var keyboardInputAccessoryDelegate: KeyboardInputAccessoryDelegate?
}

class KeyboardManagerTests: XCTestCase {
    
    // MARK: - Properites
    
    private let mockAccessoryView = MockAccessoryView()
    private let textField1 = UITextField()
    private let textField2 = UITextField()
    private var keyboardManager: KeyboardManager?
    
    // MARK: - Lifecycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        keyboardManager = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func test_TextFields_HaveCorrectInputAccessoryView() {
        keyboardManager = KeyboardManager(textFields: [textField1, textField2], inputAccessoryView: mockAccessoryView, returnKeyNavigationEnabled: false)
        
        XCTAssertEqual(keyboardManager?.textFields[0].inputAccessoryView, mockAccessoryView)
        XCTAssertEqual(keyboardManager?.textFields[1].inputAccessoryView, mockAccessoryView)
    }
    
    func test_TextFields_HaveCorrectReturnKeys() {
        keyboardManager = KeyboardManager(textFields: [textField1, textField2], inputAccessoryView: nil, returnKeyNavigationEnabled: true)
        
        XCTAssertEqual(keyboardManager?.textFields[0].returnKeyType, UIReturnKeyType.next)
        XCTAssertEqual(keyboardManager?.textFields[1].returnKeyType, UIReturnKeyType.done)
    }
}
