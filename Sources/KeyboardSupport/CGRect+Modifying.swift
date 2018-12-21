//
//  CGRect+Modifying.swift
//  KeyboardSupport
//
//  Created by Cuong Ngo on 8/30/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    public func modifying(minX: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    public func modifying(minY: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    public func modifying(height: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    public func modifying(width: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
}
