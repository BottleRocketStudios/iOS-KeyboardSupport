//
//  CGRect+Modifying.swift
//  KeyboardSupport
//
//  Created by Cuong Ngo on 8/30/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

// Testing Danger...

import CoreGraphics

extension CGRect {
    
    func modifying(width: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
}
