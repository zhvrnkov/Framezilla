//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

extension Maker {

    /// Creates edge relations.
    ///
    /// It's useful method for configure some side relations in short form.
    ///
    /// ```
    /// Instead of writing:
    ///     maker.top(10).bottom(10).and.left(10)
    /// just write:
    ///     maker.edges(top:10, left:10, bottom:10) - it's more elegant.
    /// ```
    ///
    /// - parameter top:    The top inset relation relatively super instance.
    /// - parameter left:   The left inset relation relatively super instance.
    /// - parameter bottom: The bottom inset relation relatively super instance.
    /// - parameter right:  The right inset relation relatively super instance.
    ///
    /// - returns: `Maker` instance for chaining relations.
    @discardableResult public func edges(top: Number? = nil, left: Number? = nil, bottom: Number? = nil, right: Number? = nil) -> Self {
        _ = apply(self.top, top)
        _ = apply(self.left, left)
        _ = apply(self.bottom, bottom)
        _ = apply(self.right, right)
        return self
    }

    /// Creates edge relations for super instance.
    ///
    /// - parameter insets: The insets for setting relations for super instance.
    ///
    /// - parameter sides: The sides which will inculed from edge insets to setting relations.
    ///
    /// - returns: `Maker` instance for chaining relations.
    @discardableResult public func edges(insets: UIEdgeInsets, sides: Sides = .all) -> Self {
        sides.forEach { side in
            switch side {
            case .bottom:
                bottom(inset: insets.bottom)
            case .left:
                left(inset: insets.left)
            case .right:
                right(inset: insets.right)
            case .top:
                top(inset: insets.top)
            case .horizontal:
                right(inset: insets.right)
                left(inset: insets.left)
            case .vertical:
                top(inset: insets.top)
                bottom(inset: insets.bottom)
            case .all:
                right(inset: insets.right)
                left(inset: insets.left)
                top(inset: insets.top)
                bottom(inset: insets.bottom)
            default:
                return
            }
        }
        return self
    }
}
