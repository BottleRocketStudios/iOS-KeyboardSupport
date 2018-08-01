//
//  ViewControllerD.swift
//  KeyboardSupport-iOS
//
//  Created by Cuong Ngo on 8/1/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit
import KeyboardSupport

class ViewControllerD: UIViewController, KeyboardSafeAreaAdjustable, KeyboardDismissable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismissalView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard #available(iOS 11.0, *) else { return }
        setupKeyboardSafeAreaListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard #available(iOS 11.0, *) else { return }
        stopKeyboardSafeAreaListener()
    }
}
