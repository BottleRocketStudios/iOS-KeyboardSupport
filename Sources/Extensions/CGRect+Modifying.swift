//
//  CGRect+Modifying.swift
//  KeyboardSupport
//
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import CoreGraphics

extension CGRect {
    
    /// Returns a new `CGRect` instance with a modified minX property
    ///
    /// - Parameter minX: New value for minX
    /// - Returns: New `CGRect` instance with new minX
    func modifying(minX: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    /// Returns a new `CGRect` instance with a modified minY property
    ///
    /// - Parameter minY: New value for minY
    /// - Returns: New `CGRect` instance with new minY
    func modifying(minY: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    /// Returns a new `CGRect` instance with a modified height property
    ///
    /// - Parameter height: New value for height
    /// - Returns: New `CGRect` instance with new height
    func modifying(height: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    /// Returns a new `CGRect` instance with a modified width property
    ///
    /// - Parameter width: New value for width
    /// - Returns: New `CGRect` instance with new width
    func modifying(width: CGFloat) -> CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height)
    }
}
