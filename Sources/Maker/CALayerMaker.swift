//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public final class CALayerMaker: Maker {

    // MARK: Additions

    ///    Optional semantic property for improvements readability.
    ///
    /// - returns: `Maker` instance for chaining relations.

    public var and: CALayerMaker {
        return self
    }

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
    /// - parameter top:    The top inset relation relatively superlayer.
    /// - parameter left:   The left inset relation relatively superlayer.
    /// - parameter bottom: The bottom inset relation relatively superlayer.
    /// - parameter right:  The right inset relation relatively superlayer.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func edges(top: Number? = nil, left: Number? = nil, bottom: Number? = nil, right: Number? = nil) -> CALayerMaker {
        _edges(top: top, left: left, bottom: bottom, right: right)
        return self
    }

    /// Creates edge relations for superlayer.
    ///
    /// - parameter insets: The insets for setting relations for superlayer.
    ///
    /// - parameter sides: The sides which will inculed from edge insets to setting relations.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func edges(insets: UIEdgeInsets, sides: Sides = .all) -> CALayerMaker {
        _edges(insets: insets, sides: sides)
        return self
    }

    // Creates equal relations.
    ///
    /// - parameter view:   The view, against which sets relations.
    /// - parameter insets: The insets for setting relations with `view`. Default value: `UIEdgeInsets.zero`.
    ///
    /// - returns: `CALayerMaker` instance for chaining relations.

    func equal(to view: UIView, insets: UIEdgeInsets = .zero) -> CALayerMaker {
        _equal(to: view, insets: insets)
        return self
    }

    /// Creates equal relations.
    ///
    /// - parameter layer:   The layer, against which sets relations.
    /// - parameter insets: The insets for setting relations with `view`. Default value: `UIEdgeInsets.zero`.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func equal(to layer: CALayer, insets: UIEdgeInsets = .zero) -> CALayerMaker {
        _equal(to: layer, insets: insets)
        return self
    }


    // MARK: High priority

    /// Installs constant width for current layer.
    ///
    /// - parameter width: The width for layer.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func width(_ width: Number) -> CALayerMaker {
        _width(width)
        return self
    }

    /// Creates width relation relatively another layer = Aspect ratio.
    ///
    /// Use this method when you want that your layer's width equals to another layer's height with some multiplier, for example.
    ///
    /// - note: You can not use this method with other relations except for `nui_width` and `nui_height`.
    ///
    /// - parameter relationView:   The view on which you set relation.
    /// - parameter multiplier:     The multiplier for views relation. Default multiplier value: 1.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func width(to relationView: RelationView<SizeRelation>, multiplier: Number = 1.0) -> CALayerMaker {
        _width(to: relationView, multiplier: multiplier)
        return self

    }

    /// Installs constant height for current layer.
    ///
    /// - parameter height: The height for layer.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func height(_ height: Number) -> CALayerMaker {
        _height(height)
        return self
    }

    /// Creates height relation relatively another layer = Aspect ratio.
    ///
    /// Use this method when you want that your layer's height equals to another layer's width with some multiplier, for example.
    ///
    /// - note: You can not use this method with other relations except for `nui_width` and `nui_height`.
    ///
    /// - parameter relationView:   The view on which you set relation.
    /// - parameter multiplier:     The multiplier for layer relation. Default multiplier value: 1.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func height(to relationView: RelationView<SizeRelation>, multiplier: Number = 1.0) -> CALayerMaker {
        _height(to: relationView, multiplier: multiplier)
        return self
    }

    /// Installs constant width and height at the same time.
    ///
    /// - parameter width:  The width for layer.
    /// - parameter height: The height for layer.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func size(width: Number, height: Number) -> CALayerMaker {
        _size(width: width, height: height)
        return self
    }

    /// Installs constant width and height at the same time.
    ///
    /// - parameter size:  The size for layer.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func size(_ size: CGSize) -> CALayerMaker {
        _size(size)
        return self
    }

    /// Creates left relation to superlayer.
    ///
    /// Use this method when you want to join left side of current layer with left side of superlayer.
    ///
    /// - parameter inset: The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func left(inset: Number = 0.0) -> CALayerMaker {
        _left(inset: inset)
        return self
    }

    /// Creates left relation.
    ///
    /// Use this method when you want to join left side of current layer with some horizontal side of another layer.
    ///
    /// - note: You can not use this method with other relations except for `nui_left`, `nui_centerX` and `nui_right`.
    ///
    /// - parameter relationView:   The view on which you set left relation.
    /// - parameter inset:          The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func left(to relationView: RelationView<HorizontalRelation>, inset: Number = 0.0) -> CALayerMaker {
        _left(to: relationView, inset: inset)
        return self
    }

    /// Creates top relation to superlayer.
    ///
    /// Use this method when you want to join top side of current layer with top side of superlayer.
    ///
    /// - parameter inset: The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func top(inset: Number = 0.0) -> CALayerMaker {
        _top(inset: inset)
        return self
    }

    /// Creates top relation.
    ///
    /// Use this method when you want to join top side of current layer with some vertical side of another layer.
    ///
    /// - note: You can not use this method with other relations except for `nui_top`, `nui_centerY` and `nui_bottom`.
    ///
    /// - parameter relationView:  The view on which you set top relation.
    /// - parameter inset:         The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func top(to relationView: RelationView<VerticalRelation>, inset: Number = 0.0) -> CALayerMaker {
        _top(to: relationView, inset: inset)
        return self
    }

    // MARK: Middle priority

    /// Creates margin relation for superlayer
    ///
    /// - parameter inset: The inset for setting top, left, bottom and right relations for superlayer.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func margin(_ inset: Number) -> CALayerMaker {
        _margin(inset)
        return self
    }

    /// Creates bottom relation to superlayer.
    ///
    /// Use this method when you want to join bottom side of current layer with bottom side of superlayer.
    ///
    /// - parameter inset: The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func bottom(inset: Number = 0.0) -> CALayerMaker {
        _bottom(inset: inset)
        return self
    }

    /// Creates bottom relation.
    ///
    /// Use this method when you want to join bottom side of current layer with some vertical side of another layer.
    ///
    /// - note: You can not use this method with other relations except for `nui_top`, `nui_centerY` and `nui_bottom`.
    ///
    /// - parameter relationView:   The view on which you set bottom relation.
    /// - parameter inset:          The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func bottom(to relationView: RelationView<VerticalRelation>, inset: Number = 0.0) -> CALayerMaker {
        _bottom(to: relationView, inset: inset)
        return self
    }

    /// Creates right relation to superlayer.
    ///
    /// Use this method when you want to join right side of current layer with right side of superlayer.
    ///
    /// - parameter inset: The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func right(inset: Number = 0.0) -> CALayerMaker {
        _right(inset: inset)
        return self
    }

    /// Creates right relation.
    ///
    /// Use this method when you want to join right side of current layer with some horizontal side of another layer.
    ///
    /// - note: You can not use this method with other relations except for `nui_left`, `nui_centerX` and `nui_right`.
    ///
    /// - parameter relationView:     The view on which you set right relation.
    /// - parameter inset:            The inset for additional space between layers. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func right(to relationView: RelationView<HorizontalRelation>, inset: Number = 0.0) -> CALayerMaker {
        _right(to: relationView, inset: inset)
        return self
    }


    /// Creates center relation to superlayer.
    ///
    /// Use this method when you want to center view by both axis relativity superview.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func center() -> CALayerMaker {
        _center()
        return self
    }

    /// Creates center relation.
    ///
    /// Use this method when you want to center view by both axis relativity another layer.
    ///
    /// - parameter view: The view on which you set center relation.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func center(to view: UIView) -> CALayerMaker {
        _center(to: view)
        return self
    }

    /// Creates center relation rotated around center of a specified layer.
    ///
    /// Use this method when you want to center view by both axis relativity another layer.
    ///
    /// - parameter view: The view on which you set center relation.
    /// - parameter radius: Radius of the arc on which center point will be placed.
    /// - parameter angle: Angle at which center point will be placed.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func center(to view: UIView, radius: CGFloat, angle: CGFloat) -> CALayerMaker {
        _center(to: view, radius: radius, angle: angle)
        return self
    }

    /// Creates centerY relation.
    ///
    /// Use this method when you want to join centerY of current view with centerY of superlayer.
    ///
    /// - parameter offset: Additional offset for centerY point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerY(offset: Number = 0.0) -> CALayerMaker {
        _centerY(offset: offset)
        return self
    }

    /// Creates centerY relation.
    ///
    /// Use this method when you want to join centerY of current view with some vertical side of another layer.
    ///
    /// - note: You can not use this method with other relations except for `nui_top`, `nui_centerY` and `nui_bottom`.
    ///
    /// - parameter relationView:   The view on which you set centerY relation.
    /// - parameter offset:         Additional offset for centerY point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerY(to relationView: RelationView<VerticalRelation>, offset: Number = 0.0) -> CALayerMaker {
        _centerY(to: relationView, offset: offset)
        return self
    }

    /// Creates centerY relation between two views.
    ///
    /// Use this method when you want to configure centerY point between two following views.
    ///
    /// - parameter view1: The first view between which you set `centerY` relation.
    /// - parameter view2: The second view between which you set `centerY` relation.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerY(between view1: UIView, _ view2: UIView) -> CALayerMaker {
        _centerY(between: view1, view2)
        return self
    }

    /// Creates centerY relation between two relation views.
    ///
    /// Use this method when you want to configure centerY point between two relations views.
    ///
    /// - parameter relationView1: The first relation view between which you set `centerY` relation.
    /// - parameter relationView2: The second relation view between which you set `centerY` relation.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerY(between relationView1: RelationView<VerticalRelation>,
                                           _ relationView2: RelationView<VerticalRelation>) -> CALayerMaker {
        _centerY(between: relationView1, relationView2)
        return self
    }

    /// Creates centerX relation to superlayer.
    ///
    /// Use this method when you want to join centerX of current view with centerX of superlayer.
    ///
    /// - parameter offset: Additional offset for centerX point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerX(offset: Number = 0.0) -> CALayerMaker {
        _centerX(offset: offset)
        return self
    }

    /// Creates centerX relation.
    ///
    /// Use this method when you want to join centerX of current view with some horizontal side of c
    ///
    /// - note: You can not use this method with other relations except for `nui_left`, `nui_centerX` and `nui_right`.
    ///
    /// - parameter relationView:   The view on which you set centerX relation.
    /// - parameter offset:         Additional offset for centerX point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerX(to relationView: RelationView<HorizontalRelation>, offset: Number = 0.0) -> CALayerMaker {
        _centerX(to: relationView, offset: offset)
        return self
    }

    /// Creates centerX relation between two views.
    ///
    /// Use this method when you want to configure centerX point between two following views.
    ///
    /// - parameter view1: The first view between which you set `centerX` relation.
    /// - parameter view2: The second view between which you set `centerX` relation.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerX(between view1: UIView, _ view2: UIView) -> CALayerMaker {
        _centerX(between: view1, view2)
        return self
    }

    /// Creates centerX relation between two relation views.
    ///
    /// Use this method when you want to configure centerX point between two relations views.
    ///
    /// - parameter relationView1: The first relation view between which you set `centerX` relation.
    /// - parameter relationView2: The second relation view between which you set `centerX` relation.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerX(between relationView1: RelationView<HorizontalRelation>,
                                           _ relationView2: RelationView<HorizontalRelation>) -> CALayerMaker {
        _centerX(between: relationView1, relationView2)
        return self
    }

    /// Just setting centerX.
    ///
    /// - parameter value: The value for setting centerX.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func setCenterX(value: Number) -> CALayerMaker {
        _setCenterX(value: value)
        return self
    }

    /// Just setting centerY.
    ///
    /// - parameter value: The value for setting centerY.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func setCenterY(value: Number) -> CALayerMaker {
        _setCenterY(value: value)
        return self
    }

    /// Creates center relation.
    ///
    /// Use this method when you want to center view by both axis relativity another layer.
    ///
    /// - parameter layer: The layer on which you set center relation.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func center(to layer: CALayer) -> CALayerMaker {
        _center(to: layer)
        return self
    }
}
