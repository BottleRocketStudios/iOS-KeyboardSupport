//
//  UIScrollView+Inset.swift
//  KeyboardSupport-iOS
//
//  Created by Cuong Ngo on 7/24/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    private class Box: NSObject {
        let value: UIEdgeInsets
        
        init(value: UIEdgeInsets) {
            self.value = value
        }
    }
    
    private static var insetKey = "originalContentInset"
    var originalContentInset: UIEdgeInsets? {
        get {
            guard let wrapper = objc_getAssociatedObject(self, &UIScrollView.insetKey) as? Box else { return nil }
            return wrapper.value
        }
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &UIScrollView.insetKey, Box(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
