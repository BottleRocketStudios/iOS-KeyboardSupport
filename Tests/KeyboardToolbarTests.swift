//
//  KeyboardToolbarTests.swift
//  KeyboardSupport-iOSTests
//
//  Created by Earl Gaspard on 7/31/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import XCTest
@testable import KeyboardSupport

class KeyboardToolbarTests: XCTestCase {
    
    func test_initWithFrame() {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let keyboardToolbar = KeyboardToolbar(frame: frame)
        
        XCTAssertNotNil(keyboardToolbar)
        XCTAssertEqual(keyboardToolbar.frame.height, frame.height)
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
        keyboardToolbar.addBackButton(title: "Title")

        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_addBackButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addBackButton(image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_addNextButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addNextButton(title: "Title")
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_addNextButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addNextButton(image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_addDoneButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addDoneButton(title: "Title")
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_addDoneButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addDoneButton(image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_addSystemDoneButton() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addSystemDoneButton()
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
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
        keyboardToolbar.addBackButton(title: "Title")
        keyboardToolbar.backButtonTapped(keyboardToolbar.items!.first!)
        XCTAssertEqual(mockDelegate.tapType, .back)
    }
    
    func test_nextButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        let mockDelegate = MockKeyboardAccessoryDelegate()
        keyboardToolbar.keyboardAccessoryDelegate = mockDelegate
        keyboardToolbar.addNextButton(title: "Title")
        keyboardToolbar.nextButtonTapped(keyboardToolbar.items!.first!)
        XCTAssertEqual(mockDelegate.tapType, .next)
    }
    
    func test_doneButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        let mockDelegate = MockKeyboardAccessoryDelegate()
        keyboardToolbar.keyboardAccessoryDelegate = mockDelegate
        keyboardToolbar.addDoneButton(title: "Title")
        keyboardToolbar.doneButtonTapped(keyboardToolbar.items!.first!)
        XCTAssertEqual(mockDelegate.tapType, .done)
    }
}

private extension KeyboardToolbarTests {
    
    @objc private func buttonTapped(_ sender: UIBarButtonItem) {}
}
