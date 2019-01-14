//
//  AutoKeyboardNavigatorTests.swift
//  KeyboardSupport-iOSTests
//
//  Created by John Davis on 12/18/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import XCTest
@testable import KeyboardSupport

class AutoKeyboardNavigatorTests: XCTestCase {

    // MARK: - Properties
    
    private var keyboardToolbar: KeyboardToolbar!
    private var keyboardNavigator: KeyboardAutoNavigator?
    private var delegateMock: MockKeyboardAutoNavigatorDelegate?
    
    // MARK: - Tests
    
    override func setUp() {
        super.setUp()
        delegateMock = MockKeyboardAutoNavigatorDelegate()
        keyboardToolbar = KeyboardToolbar()
        keyboardNavigator = KeyboardAutoNavigator(containerView: UIView(), defaultToolbar: keyboardToolbar, returnKeyNavigationEnabled: true)
        keyboardNavigator?.delegate = delegateMock
    }

    override func tearDown() {
        super.tearDown()
        keyboardNavigator = nil
    }

    func test_keyboardAutoNavigator_invokesDelegateOnNext() {
        keyboardNavigator?.keyboardAccessoryDidTapNext(keyboardToolbar)
        XCTAssertEqual(delegateMock?.keyboardNavigatorDidTapNextCount, 1)
        XCTAssertTrue(delegateMock?.keyboardNavigatorDidTapNextLastNavigator === keyboardNavigator )
    }
    
    func test_keyboardAutoNavigator_invokesDelegateOnBack() {
        keyboardNavigator?.keyboardAccessoryDidTapBack(keyboardToolbar)
        XCTAssertEqual(delegateMock?.keyboardNavigatorDidTapBackCount, 1)
        XCTAssertTrue(delegateMock?.keyboardNavigatorDidTapBackLastNavigator === keyboardNavigator )
    }
    
    func test_keyboardAutoNavigator_invokesDelegateOnDone() {
        keyboardNavigator?.keyboardAccessoryDidTapDone(keyboardToolbar)
        XCTAssertEqual(delegateMock?.keyboardNavigatorDidTapDoneCount, 1)
        XCTAssertTrue(delegateMock?.keyboardNavigatorDidTapDoneLastNavigator === keyboardNavigator )
    }
}
