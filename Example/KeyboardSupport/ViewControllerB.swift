//
//  ViewControllerB.swift
//  KeyboardSupport_Example
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import KeyboardSupport

/// Demonstrates using a bottom constraint to move a view above the keyboard.
class ViewControllerB: KeyboardSupportViewController {

    // MARK: - Properties
    
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        let configuration = KeyboardSupportConfiguration(bottomConstraint: bottomConstraint, constraintOffset: tabBarHeight, usesKeyboardNextButtons: false)
        configureKeyboardSupport(with: configuration)
    }
}
