//
//  UIEdgeInsets+KeyboardSupport.swift
//  KeyboardSupport
//
//  Created by John Davis on 1/15/19.
//  Copyright © 2019 Bottle Rocket. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    /// Constructs and returns a UIEdgeInsets instance using the max edge values from each argument.
    ///
    /// - Parameters:
    ///   - lhs: UIEdgeInsets to compare
    ///   - rhs: Other UIEdgeInsets to compare
    /// - Returns: Combined UIEdgeInsets using the max values for each edge
    static func max(lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: Swift.max(lhs.top, rhs.top),
                            left: Swift.max(lhs.left, rhs.left),
                            bottom: Swift.max(lhs.bottom, rhs.bottom),
                            right: Swift.max(lhs.right, rhs.right))
    }
}
