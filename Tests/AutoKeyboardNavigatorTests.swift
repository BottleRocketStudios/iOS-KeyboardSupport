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
    
    private var keyboardNavigator: KeyboardAutoNavigator?
    private var delegateMock: MockKeyboardAutoNavigatorDelegate?
    
    // MARK: - Tests
    
    override func setUp() {
        super.setUp()
        delegateMock = MockKeyboardAutoNavigatorDelegate()
        keyboardNavigator = KeyboardAutoNavigator(navigationContainer: UIView(), defaultToolbar: KeyboardToolbar(), returnKeyNavigationEnabled: true)
        keyboardNavigator?.delegate = delegateMock
    }

    override func tearDown() {
        super.tearDown()
        keyboardNavigator = nil
    }

    func test_keyboardAutoNavigator_invokesDelegateOnNext() {
        keyboardNavigator?.didTapNext()
        XCTAssertEqual(delegateMock?.keyboardNavigatorDidTapNextCount, 1)
        XCTAssertTrue(delegateMock?.keyboardNavigatorDidTapNextLastNavigator === keyboardNavigator )
    }
    
    func test_keyboardAutoNavigator_invokesDelegateOnBack() {
        keyboardNavigator?.didTapBack()
        XCTAssertEqual(delegateMock?.keyboardNavigatorDidTapBackCount, 1)
        XCTAssertTrue(delegateMock?.keyboardNavigatorDidTapBackLastNavigator === keyboardNavigator )
    }
    
    func test_keyboardAutoNavigator_invokesDelegateOnDone() {
        keyboardNavigator?.didTapDone()
        XCTAssertEqual(delegateMock?.keyboardNavigatorDidTapDoneCount, 1)
        XCTAssertTrue(delegateMock?.keyboardNavigatorDidTapDoneLastNavigator === keyboardNavigator )
    }
}
