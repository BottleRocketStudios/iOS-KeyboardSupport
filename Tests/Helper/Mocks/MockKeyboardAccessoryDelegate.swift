//
//  MockKeyboardAccessoryDelegate.swift
//  Tests
//
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit
import KeyboardSupport

enum TapType {
    case back
    case next
    case done
}

class MockKeyboardAccessoryDelegate: KeyboardAccessoryDelegate {
    var tapType: TapType?
    
    func keyboardAccessoryDidTapBack(_ accessory: UIView) {
        tapType = .back
    }
    
    func keyboardAccessoryDidTapNext(_ accessory: UIView) {
        tapType = .next
    }
    
    func keyboardAccessoryDidTapDone(_ accessory: UIView) {
        tapType = .done
    }
}
