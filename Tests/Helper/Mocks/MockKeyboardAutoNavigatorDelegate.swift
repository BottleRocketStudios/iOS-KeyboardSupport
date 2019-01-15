//
//  MockKeyboardAutoNavigatorDelegate.swift
//  KeyboardSupport-iOS
//
//  Created by John Davis on 12/18/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import Foundation
import KeyboardSupport

/// Mock Delegate to be used when testing the behavior of how KeyboardAutoNavigator invokes its delegate
class MockKeyboardAutoNavigatorDelegate: KeyboardAutoNavigatorDelegate {
    var keyboardNavigatorDidTapBackCount: Int = 0
    var keyboardNavigatorDidTapBackLastNavigator: KeyboardAutoNavigator?
    
    var keyboardNavigatorDidTapNextCount: Int = 0
    var keyboardNavigatorDidTapNextLastNavigator: KeyboardAutoNavigator?
    
    var keyboardNavigatorDidTapDoneCount: Int = 0
    var keyboardNavigatorDidTapDoneLastNavigator: KeyboardAutoNavigator?
    
    func keyboardNavigatorDidTapBack(_ navigator: KeyboardAutoNavigator) {
        keyboardNavigatorDidTapBackCount += 1
        keyboardNavigatorDidTapBackLastNavigator = navigator
    }
    
    func keyboardNavigatorDidTapNext(_ navigator: KeyboardAutoNavigator) {
        keyboardNavigatorDidTapNextCount += 1
        keyboardNavigatorDidTapNextLastNavigator = navigator
    }
    
    func keyboardNavigatorDidTapDone(_ navigator: KeyboardAutoNavigator) {
        keyboardNavigatorDidTapDoneCount += 1
        keyboardNavigatorDidTapDoneLastNavigator = navigator
    }
}
