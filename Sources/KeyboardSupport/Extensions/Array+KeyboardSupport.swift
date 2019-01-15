//
//  Array+KeyboardSupport.swift
//  KeyboardSupport
//
//  Created by John Davis on 12/3/18.
//  Copyright © 2018 Bottle Rocket. All rights reserved.
//

import Foundation

// MARK: - UIView Array Extension
extension Array where Element: UIView {
    
    /// Sorts an array of Views arranging them from left to right, top to bottom based on their minX and minY values.
    ///
    /// - Parameter container: Superview of all elements to be sorted by position.
    /// - Returns: Sorted array of UIView elements.
    func sortedByPosition(in container: UIView) -> [Element] {
        return sorted(by: { (view1: Element, view2: Element) -> Bool in
            
            let adjustedFrame1 = view1.convert(view1.frame, to: container)
            let adjustedFrame2 = view2.convert(view2.frame, to: container)
            
            let minX1 = adjustedFrame1.minX
            let minY1 = adjustedFrame1.minY
            let minX2 = adjustedFrame2.minX
            let minY2 = adjustedFrame2.minY
            
            if minY1 != minY2 {
                return minY1 < minY2
            } else {
                return minX1 < minX2
            }
        })
    }
}
