//
//  AutoPilotTests.swift
//  KeyboardSupport-iOSTests
//
//  Created by John Davis on 12/18/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit
import XCTest
@testable import KeyboardSupport

class AutoPilotTests: XCTestCase {

    // MARK: - Properties
    
    private var viewController: AutoNavigatorViewController!
    private var window: UIWindow!
    
    // MARK: - Tests
    
    override func setUp() {
        super.setUp()
        viewController = UIStoryboard.init(name: "Main", bundle: Bundle(for: AutoPilotTests.self)).instantiateViewController(withIdentifier: "AutoNavigatorViewController") as? AutoNavigatorViewController
        
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    func test_KeyboardAutoNavigator_AutoPilotDoesNavigateNext() {
        // Arrange / Act
        let nextFrom1 = KeyboardAutoNavigator.AutoPilot.nextField(from: viewController.textField1, in: viewController.view)
        let nextFrom2 = KeyboardAutoNavigator.AutoPilot.nextField(from: viewController.textField2, in: viewController.view)
        let nextFromView = KeyboardAutoNavigator.AutoPilot.nextField(from: viewController.textView, in: viewController.view)
        let nextFrom3 = KeyboardAutoNavigator.AutoPilot.nextField(from: viewController.textField3, in: viewController.view)
        
        // Assert
        XCTAssertEqual(nextFrom1!, viewController.textField2)
        XCTAssertEqual(nextFrom2!, viewController.textView)
        XCTAssertEqual(nextFromView!, viewController.textField3)
        XCTAssertNil(nextFrom3)
    }
    
    func test_KeyboardAutoNavigator_AutoPilotDoesNavigateBack() {
        // Arrange / Act
        let backFrom1 = KeyboardAutoNavigator.AutoPilot.previousField(from: viewController.textField1, in: viewController.view)
        let backFrom2 = KeyboardAutoNavigator.AutoPilot.previousField(from: viewController.textField2, in: viewController.view)
        let backFromView = KeyboardAutoNavigator.AutoPilot.previousField(from: viewController.textView, in: viewController.view)
        let backFrom3 = KeyboardAutoNavigator.AutoPilot.previousField(from: viewController.textField3, in: viewController.view)
        
        // Assert
        XCTAssertNil(backFrom1)
        XCTAssertEqual(backFrom2!, viewController.textField1)
        XCTAssertEqual(backFromView!, viewController.textField2)
        XCTAssertEqual(backFrom3!, viewController.textView)
    }
}
