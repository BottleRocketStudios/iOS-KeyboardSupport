//
//  ViewControllerE.swift
//  KeyboardSupport-iOS
//
//  Created by Cuong Ngo on 8/30/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import Foundation

/// Demonstrates that KeyboardRespondable scrolls to cursor on large UITextView's
class ViewControllerE: UIViewController, KeyboardRespondable {
    
    // MARK: - Properties
    
    @IBOutlet private var scrollView: UIScrollView!
    
    // MARK: - KeyboardRespondable
    
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardScrollableScrollView = scrollView
        setupKeyboardRespondable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}
