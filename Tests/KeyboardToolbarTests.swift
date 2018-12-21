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
    
    func test_KeyboardToolbar_InitWithFrame() {
        let keyboardToolbar = KeyboardToolbar()
        
        XCTAssertNotNil(keyboardToolbar)
        XCTAssertEqual(keyboardToolbar.frame.height, 50)
        XCTAssertTrue((keyboardToolbar.items!.isEmpty))
    }
    
    func test_KeyboardToolbar_InitWithCoder() {
        let archiver = NSKeyedUnarchiver(forReadingWith: Data())
        let keyboardToolbar = KeyboardToolbar(coder: archiver)
        
        XCTAssertNotNil(keyboardToolbar)
        XCTAssertTrue(keyboardToolbar!.items!.isEmpty)
    }
    
    func test_KeyboardToolbar_AddButton() {
        let keyboardToolbar = KeyboardToolbar()
        let barButton = UIBarButtonItem(title: "Title", style: .plain, target: self, action: #selector(buttonTapped))
        keyboardToolbar.addButton(barButton)
        
        XCTAssertEqual(keyboardToolbar.items?.first, barButton)
    }
    
    func test_KeyboardToolbar_AddBackButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addBackButton(title: "Title")

        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_AddBackButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addBackButton(image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_AddNextButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addNextButton(title: "Title")
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_AddNextButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addNextButton(image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_AddDoneButtonWithTitle() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addDoneButton(title: "Title")
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_AddDoneButtonWithImage() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addDoneButton(image: UIImage())
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_AddSystemDoneButton() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addSystemDoneButton()
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_AddFlexibleSpace() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.addFlexibleSpace()
        
        XCTAssertEqual(keyboardToolbar.items?.count, 1)
    }
    
    func test_KeyboardToolbar_BackButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.keyboardAccessoryDelegate = self
        keyboardToolbar.addBackButton(title: "Title")
        keyboardToolbar.backButtonTapped(keyboardToolbar.items!.first!)
    }
    
    func test_KeyboardToolbar_NextButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.keyboardAccessoryDelegate = self
        keyboardToolbar.addNextButton(title: "Title")
        keyboardToolbar.nextButtonTapped(keyboardToolbar.items!.first!)
    }
    
    func test_KeyboardToolbar_DoneButtonTapped() {
        let keyboardToolbar = KeyboardToolbar()
        keyboardToolbar.keyboardAccessoryDelegate = self
        keyboardToolbar.addDoneButton(title: "Title")
        keyboardToolbar.doneButtonTapped(keyboardToolbar.items!.first!)
    }
}

extension KeyboardToolbarTests: KeyboardAccessoryDelegate {
    
    func keyboardAccessoryDidTapBack(_ accessory: UIView) {
        XCTAssertTrue(accessory is KeyboardToolbar)
    }
    
    func keyboardAccessoryDidTapNext(_ accessory: UIView) {
        XCTAssertTrue(accessory is KeyboardToolbar)
    }
    
    func keyboardAccessoryDidTapDone(_ accessory: UIView) {
        XCTAssertTrue(accessory is KeyboardToolbar)
    }
}

private extension KeyboardToolbarTests {
    
    @objc private func buttonTapped(_ sender: UIBarButtonItem) {}
}
