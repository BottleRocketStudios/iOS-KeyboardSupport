//
//  KeyboardToolbarTests.swift
//  Tests
//
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import XCTest
@testable import KeyboardSupport

class KeyboardToolbarTests: XCTestCase {
    
    func test_initWithFrame() {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let keyboardToolbar = KeyboardToolbar(frame: frame)
        
        XCTAssertNotNil(keyboardToolbar)
        XCTAssertEqual(keyboardToolbar.frame, frame)
        XCTAssertTrue((keyboardToolbar.items!.isEmpty))
    }
    
    func test_initWithCoder() {
        let archiver = NSKeyedUnarchiver(forReadingWith: Data())
        let keyboardToolbar = KeyboardToolbar(coder: archiver)
        
        XCTAssertNotNil(keyboardToolbar)
        XCTAssertTrue(keyboardToolbar!.items!.isEmpty)
    }
    
    func test_addButton() {
        let keyboardToolbar = KeyboardToolbar()
        let barButton = UIBarButtonItem(title: "Title", style: .plain, target: self, action: #selector(buttonTapped))
        keyboardToolbar.addButton(barButton)
        
        XCTAssertEqual(keyboardToolbar.items?.first, barButton)
    }
    
    func test_addBackButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addButton(type: .back, title: "Back")

        XCTAssertEqual(keyboardToolbar.items?.count, 1)
        XCTAssertNotNil(keyboardToolbar.backButton)
    }
    
    func test_addBackButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addButton(type: .back, image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
        XCTAssertNotNil(keyboardToolbar.backButton)
    }
    
    func test_addNextButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addButton(type: .next, title: "Next")
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
        XCTAssertNotNil(keyboardToolbar.nextButton)
    }
    
    func test_addNextButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addButton(type: .next, image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
        XCTAssertNotNil(keyboardToolbar.nextButton)
    }
    
    func test_addDoneButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addButton(type: .done, title: "Done")
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
        XCTAssertNotNil(keyboardToolbar.doneButton)
    }
    
    func test_addDoneButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addButton(type: .done, image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
        XCTAssertNotNil(keyboardToolbar.doneButton)
    }
    
    func test_addSystemDoneButton() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addSystemDoneButton()
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
        XCTAssertNotNil(keyboardToolbar.doneButton)
    }
    
    func test_addFlexibleSpace() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addFlexibleSpace()
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_backButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        let mockDelegate = MockKeyboardAccessoryDelegate()
        keyboardToolbar.keyboardAccessoryDelegate = mockDelegate
        keyboardToolbar.addButton(type: .back, title: "Back")
        keyboardToolbar.backButtonTapped(keyboardToolbar.items!.first!)
        XCTAssertEqual(mockDelegate.tapType, .back)
    }
    
    func test_nextButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        let mockDelegate = MockKeyboardAccessoryDelegate()
        keyboardToolbar.keyboardAccessoryDelegate = mockDelegate
        keyboardToolbar.addButton(type: .next, title: "Next")
        keyboardToolbar.nextButtonTapped(keyboardToolbar.items!.first!)
        XCTAssertEqual(mockDelegate.tapType, .next)
    }
    
    func test_doneButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        let mockDelegate = MockKeyboardAccessoryDelegate()
        keyboardToolbar.keyboardAccessoryDelegate = mockDelegate
        keyboardToolbar.addButton(type: .done, title: "Done")
        keyboardToolbar.doneButtonTapped(keyboardToolbar.items!.first!)
        XCTAssertEqual(mockDelegate.tapType, .done)
    }
}

private extension KeyboardToolbarTests {
    
    @objc private func buttonTapped(_ sender: UIBarButtonItem) {}
}
