//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

extension Maker {

    /// Creates equal relations.
    ///
    /// - parameter view:   The view, against which sets relations.
    /// - parameter insets: The insets for setting relations with `view`. Default value: `UIEdgeInsets.zero`.
    ///
    /// - returns: `UIViewMaker` instance for chaining relations.
    @discardableResult public func equal(to view: UIView, insets: UIEdgeInsets = .zero) -> Self {
        return equal(to: .view(view), insets: insets)
    }

    /// Creates equal relations.
    ///
    /// - parameter layer:   The layer, against which sets relations.
    /// - parameter insets: The insets for setting relations with `layer`. Default value: `UIEdgeInsets.zero`.
    ///
    /// - returns: `Maker` instance for chaining relations.
    @discardableResult public func equal(to layer: CALayer, insets: UIEdgeInsets = .zero) -> Self {
        return equal(to: .layer(layer), insets: insets)
    }

    private func equal(to element: ElementType, insets: UIEdgeInsets = .zero) -> Self {
        let topView = RelationView<VerticalRelation>(element: element, relation: .top)
        let leftView = RelationView<HorizontalRelation>(element: element, relation: .left)
        let bottomView = RelationView<VerticalRelation>(element: element, relation: .bottom)
        let rightView = RelationView<HorizontalRelation>(element: element, relation: .right)
        
        return top(to: topView, inset: insets.top)
            .left(to: leftView, inset: insets.left)
            .bottom(to: bottomView, inset: insets.bottom)
            .right(to: rightView, inset: insets.right)
    }
}
