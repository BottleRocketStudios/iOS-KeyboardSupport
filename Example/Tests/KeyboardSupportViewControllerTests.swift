//
//  KeyboardSupportViewControllerTests.swift
//  KeyboardSupport_Tests
//
//  Copyright © 2018 Bottle Rocket Studios. All rights reserved.
//

import XCTest
import KeyboardSupport
@testable import KeyboardSupport_Example

class KeyboardSupportViewControllerTests: XCTestCase {
    
    var viewControllerA: ViewControllerA?

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewControllerA = storyboard.instantiateViewController(withIdentifier: "ViewControllerA") as? ViewControllerA
        viewControllerA?.loadViewIfNeeded()
    }

    override func tearDown() {
        viewControllerA = nil
        super.tearDown()
    }

    func test_Configuration_HasCorrectValues() {
        let configuration = viewControllerA!.configuration
        
        XCTAssertEqual(configuration.textFields.count, 8)
        XCTAssertNotNil(configuration.scrollView)
        XCTAssertNil(configuration.bottomConstraint)
        XCTAssertEqual(configuration.constraintOffset, 0)
        XCTAssertTrue(configuration.usesDismissalView)
        XCTAssertTrue(configuration.usesKeyboardNextButtons)
        XCTAssertNotNil(configuration.keyboardInputAccessoryView)
    }
    
    func test_CurrentTextField_IsNil() {
        XCTAssertNil(viewControllerA?.currentTextField)
    }

    func test_KeyboardSupportDelegate_IsNotNil() {
        XCTAssertNotNil(viewControllerA?.keyboardSupportDelegate)
    }
}
