//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public final class UIViewMaker: Maker {

    /// Resizes the current view so it just encloses its subviews.
    ///
    /// - returns: `Maker` instance for chaining relations.

    unowned let uiView: UIView

    override init(view: ViewType) {
        guard case let .view(view) = view else {
            fatalError("UIViewMaker was initialized with wong ViewType")
        }
        self.uiView = view
        super.init(view: .view(view))
    }

    // MARK: Additions

    ///    Optional semantic property for improvements readability.
    ///
    /// - returns: `Maker` instance for chaining relations.

    public var and: UIViewMaker {
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
    /// - parameter top:    The top inset relation relatively superview.
    /// - parameter left:   The left inset relation relatively superview.
    /// - parameter bottom: The bottom inset relation relatively superview.
    /// - parameter right:  The right inset relation relatively superview.
    ///
    /// - returns: `UIViewMaker` instance for chaining relations.

    @discardableResult public func edges(top: Number? = nil, left: Number? = nil, bottom: Number? = nil, right: Number? = nil) -> UIViewMaker {
        _edges(top: top, left: left, bottom: bottom, right: right)
        return self
    }

    /// Creates edge relations for superview.
    ///
    /// - parameter insets: The insets for setting relations for superview.
    ///
    /// - parameter sides: The sides which will inculed from edge insets to setting relations.
    ///
    /// - returns: `UIViewMaker` instance for chaining relations.

    @discardableResult public func edges(insets: UIEdgeInsets, sides: Sides = .all) -> UIViewMaker {
        _edges(insets: insets, sides: sides)
        return self
    }

    /// Creates equal relations.
    ///
    /// - parameter view:   The view, against which sets relations.
    /// - parameter insets: The insets for setting relations with `view`. Default value: `UIEdgeInsets.zero`.
    ///
    /// - returns: `UIViewMaker` instance for chaining relations.

    @discardableResult public func equal(to view: UIView, insets: UIEdgeInsets = .zero) -> UIViewMaker {
        _equal(to: view, insets: insets)
        return self
    }

    /// Creates equal relations.
    ///
    /// - parameter layer:   The layer, against which sets relations.
    /// - parameter insets: The insets for setting relations with `view`. Default value: `UIEdgeInsets.zero`.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func equal(to layer: CALayer, insets: UIEdgeInsets = .zero) -> UIViewMaker {
        _equal(to: layer, insets: insets)
        return self
    }

    // MARK: High priority

    /// Installs constant width for current view.
    ///
    /// - parameter width: The width for view.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func width(_ width: Number) -> UIViewMaker {
        _width(width)
        return self
    }

    /// Creates width relation relatively another view = Aspect ratio.
    ///
    /// Use this method when you want that your view's width equals to another view's height with some multiplier, for example.
    ///
    /// - note: You can not use this method with other relations except for `nui_width` and `nui_height`.
    ///
    /// - parameter relationView:   The view on which you set relation.
    /// - parameter multiplier:     The multiplier for views relation. Default multiplier value: 1.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func width(to relationView: RelationView<SizeRelation>, multiplier: Number = 1.0) -> UIViewMaker {
        _width(to: relationView, multiplier: multiplier)
        return self

    }

    /// Installs constant height for current view.
    ///
    /// - parameter height: The height for view.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func height(_ height: Number) -> UIViewMaker {
        _height(height)
        return self
    }

    /// Creates height relation relatively another view = Aspect ratio.
    ///
    /// Use this method when you want that your view's height equals to another view's width with some multiplier, for example.
    ///
    /// - note: You can not use this method with other relations except for `nui_width` and `nui_height`.
    ///
    /// - parameter relationView:   The view on which you set relation.
    /// - parameter multiplier:     The multiplier for views relation. Default multiplier value: 1.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func height(to relationView: RelationView<SizeRelation>, multiplier: Number = 1.0) -> UIViewMaker {
        _height(to: relationView, multiplier: multiplier)
        return self
    }

    /// Installs constant width and height at the same time.
    ///
    /// - parameter width:  The width for view.
    /// - parameter height: The height for view.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func size(width: Number, height: Number) -> UIViewMaker {
        _size(width: width, height: height)
        return self
    }

    /// Installs constant width and height at the same time.
    ///
    /// - parameter size:  The size for view.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func size(_ size: CGSize) -> UIViewMaker {
        _size(size)
        return self
    }

    /// Resizes the current view so it just encloses its subviews.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func sizeToFit() -> UIViewMaker {
        uiView.sizeToFit()
        setHighPriorityValue(uiView.bounds.width, for: .width)
        setHighPriorityValue(uiView.bounds.height, for: .height)
        return self
    }


    /// Calculates the size that best fits the specified size.
    ///
    /// ```
    ///     maker.sizeThatFits(size: CGSize(width: cell.frame.width, height: cell.frame.height)
    /// ```
    /// - parameter size: The size for best-fitting.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func sizeThatFits(size: CGSize) -> UIViewMaker {
        let fitSize = uiView.sizeThatFits(size)
        let width = min(size.width, fitSize.width)
        let height = min(size.height, fitSize.height)
        setHighPriorityValue(width, for: .width)
        setHighPriorityValue(height, for: .height)
        return self
    }

    /// Resizes and moves the receiver view so it just encloses its subviews only for height.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func heightToFit() -> UIViewMaker {
        return heightThatFits(maxHeight: CGFloat.greatestFiniteMagnitude)
    }

    /// Calculates the height that best fits the specified size.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func heightThatFits(maxHeight: Number) -> UIViewMaker {
        let handler = { [unowned self] in
            let fitWidth: CGFloat

            if let parameter = self.widthParameter {
                fitWidth = parameter.value
            }
            else if let parameter = self.widthToParameter {
                fitWidth = self.relationSize(view: parameter.view, for: parameter.relationType) * parameter.value
            }
            else if let leftParameter = self.leftParameter, let rightParameter = self.rightParameter {
                let leftViewX = self.convertedValue(for: leftParameter.relationType, with: leftParameter.view) + leftParameter.value
                let rightViewX = self.convertedValue(for: rightParameter.relationType, with: rightParameter.view) - rightParameter.value

                fitWidth = rightViewX - leftViewX
            }
            else {
                fitWidth = .greatestFiniteMagnitude
            }

            let fitSize = self.uiView.sizeThatFits(CGSize(width: fitWidth, height: .greatestFiniteMagnitude))
            self.newRect.setValue(min(maxHeight.value, fitSize.height), for: .height)
        }
        handlers.append((.high, handler))
        return self
    }

    /// Resizes and moves the receiver view so it just encloses its subviews only for width.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func widthToFit() -> UIViewMaker {
        return widthThatFits(maxWidth: CGFloat.greatestFiniteMagnitude)
    }

    /// Calculates the width that best fits the specified size.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func widthThatFits(maxWidth: Number) -> UIViewMaker {
        let handler = { [unowned self] in
            let fitHeight: CGFloat

            if let parameter = self.heightParameter {
                fitHeight = parameter.value
            }
            else if let parameter = self.heightToParameter {
                fitHeight = self.relationSize(view: parameter.view, for: parameter.relationType) * parameter.value
            }
            else if let topParameter = self.topParameter, let bottomParameter = self.bottomParameter {
                let topViewY = self.convertedValue(for: topParameter.relationType, with: topParameter.view) + topParameter.value
                let bottomViewY = self.convertedValue(for: bottomParameter.relationType, with: bottomParameter.view) - bottomParameter.value

                fitHeight = bottomViewY - topViewY
            }
            else {
                fitHeight = .greatestFiniteMagnitude
            }

            let fitSize = self.uiView.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: fitHeight))
            self.newRect.setValue(min(maxWidth.value, fitSize.width), for: .width)
        }

        handlers.append((.high, handler))
        return self
    }

    /// Creates a right relation to the superview's safe area.
    ///
    /// Use this method when you want to join a right side of current view with right edge of the superview's safe area.
    ///
    /// - note: In earlier versions of OS than iOS 11, it creates a right relation to a superview.
    ///
    /// - parameter safeArea:  The safe area of current view. Use a `nui_safeArea` - global property.
    /// - parameter inset:     The inset for additional space to safe area. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @available(*, deprecated, message: "Use `right(to: view.nui_safeArea.right, inset: ...)` instead")
    @discardableResult public func right(to safeArea: SafeArea, inset: Number = 0.0) -> UIViewMaker {
        if #available(iOS 11.0, *) {
            guard let superview = view.layout.superview,
                let layout = superview.layout as? UIViewLayout else {
                assertionFailure("Can not configure a right relation to the safe area without superview.")
                return self
            }
            _right(inset: layout.safeAreaInsets.right + inset.value)
        }
        else {
            _right(inset: inset)
        }
        return self
    }


    /// Creates a left relation to the superview's safe area.
    ///
    /// Use this method when you want to join a left side of current view with left edge of the superview's safe area.
    ///
    /// - note: In earlier versions of OS than iOS 11, it creates a left relation to a superview.
    ///
    /// - parameter safeArea:  The safe area of current view. Use a `nui_safeArea` - global property.
    /// - parameter inset:     The inset for additional space to safe area. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @available(*, deprecated, message: "Use `left(to: view.nui_safeArea.left, inset: ...)` instead")
    @discardableResult public func left(to safeArea: SafeArea, inset: Number = 0.0) -> UIViewMaker {
        if #available(iOS 11.0, *) {
            guard let superview = view.layout.superview,
                let layout = superview.layout as? UIViewLayout else {
                assertionFailure("Can not configure a left relation to the safe area without superview.")
                return self
            }
            return left(inset: layout.safeAreaInsets.left + inset.value)
        }
        else {
            return left(inset: inset)
        }
    }

    /// Creates left relation to superview.
    ///
    /// Use this method when you want to join left side of current view with left side of superview.
    ///
    /// - parameter inset: The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func left(inset: Number = 0.0) -> UIViewMaker {
        _left(inset: inset)
        return self
    }

    /// Creates left relation.
    ///
    /// Use this method when you want to join left side of current view with some horizontal side of another view.
    ///
    /// - note: You can not use this method with other relations except for `nui_left`, `nui_centerX` and `nui_right`.
    ///
    /// - parameter relationView:   The view on which you set left relation.
    /// - parameter inset:          The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func left(to relationView: RelationView<HorizontalRelation>, inset: Number = 0.0) -> UIViewMaker {
        _left(to: relationView, inset: inset)
        return self
    }

    /// Creates top relation to superview.
    ///
    /// Use this method when you want to join top side of current view with top side of superview.
    ///
    /// - parameter inset: The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func top(inset: Number = 0.0) -> UIViewMaker {
        _top(inset: inset)
        return self
    }

    /// Creates a top relation to the superview's safe area.
    ///
    /// Use this method when you want to join a top side of current view with top edge of the superview's safe area.
    ///
    /// - note: In earlier versions of OS than iOS 11, it creates a top relation to a superview.
    ///
    /// - parameter safeArea:  The safe area of current view. Use a `nui_safeArea` - global property.
    /// - parameter inset:     The inset for additional space to safe area. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @available(*, deprecated, message: "Use `top(to: view.nui_safeArea.top, inset: ...)` instead")
    @discardableResult public func top(to safeArea: SafeArea, inset: Number = 0.0) -> UIViewMaker {
        if #available(iOS 11.0, *) {
            guard let superview = view.layout.superview,
                let layout = superview.layout as? UIViewLayout else {
                assertionFailure("Can not configure a top relation to the safe area without superview.")
                return self
            }
            return top(inset: layout.safeAreaInsets.top + inset.value)
        }
        else {
            return top(inset: inset)
        }
    }

    /// Creates top relation.
    ///
    /// Use this method when you want to join top side of current view with some vertical side of another view.
    ///
    /// - note: You can not use this method with other relations except for `nui_top`, `nui_centerY` and `nui_bottom`.
    ///
    /// - parameter relationView:  The view on which you set top relation.
    /// - parameter inset:         The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func top(to relationView: RelationView<VerticalRelation>, inset: Number = 0.0) -> UIViewMaker {
        _top(to: relationView, inset: inset)
        return self
    }

    // MARK: Middle priority

    /// Creates margin relation for superview.
    ///
    /// - parameter inset: The inset for setting top, left, bottom and right relations for superview.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func margin(_ inset: Number) -> UIViewMaker {
        _margin(inset)
        return self
    }

    /// Creates bottom relation to superview.
    ///
    /// Use this method when you want to join bottom side of current view with bottom side of superview.
    ///
    /// - parameter inset: The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func bottom(inset: Number = 0.0) -> UIViewMaker {
        _bottom(inset: inset)
        return self
    }

    /// Creates a bottom relation to the superview's safe area.
    ///
    /// Use this method when you want to join a bottom side of current view with bottom edge of the superview's safe area.
    ///
    /// - note: In earlier versions of OS than iOS 11, it creates a bottom relation to a superview.
    ///
    /// - parameter safeArea:  The safe area of current view. Use a `nui_safeArea` - global property.
    /// - parameter inset:     The inset for additional space to safe area. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @available(*, deprecated, message: "Use `bottom(to: view.nui_safeArea.bottom, inset: ...)` instead")
    @discardableResult public func bottom(to safeArea: SafeArea, inset: Number = 0.0) -> UIViewMaker {
        if #available(iOS 11.0, *) {
            guard let superview = view.layout.superview,
                let layout = superview.layout as? UIViewLayout else {
                assertionFailure("Can not configure a bottom relation to the safe area without superview.")
                return self
            }
            return bottom(inset: layout.safeAreaInsets.bottom + inset.value)
        }
        else {
            return bottom(inset: inset)
        }
    }

    /// Creates bottom relation.
    ///
    /// Use this method when you want to join bottom side of current view with some vertical side of another view.
    ///
    /// - note: You can not use this method with other relations except for `nui_top`, `nui_centerY` and `nui_bottom`.
    ///
    /// - parameter relationView:   The view on which you set bottom relation.
    /// - parameter inset:          The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func bottom(to relationView: RelationView<VerticalRelation>, inset: Number = 0.0) -> UIViewMaker {
        _bottom(to: relationView, inset: inset)
        return self
    }

    /// Creates right relation to superview.
    ///
    /// Use this method when you want to join right side of current view with right side of superview.
    ///
    /// - parameter inset: The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func right(inset: Number = 0.0) -> UIViewMaker {
        _right(inset: inset)
        return self
    }

    /// Creates right relation.
    ///
    /// Use this method when you want to join right side of current view with some horizontal side of another view.
    ///
    /// - note: You can not use this method with other relations except for `nui_left`, `nui_centerX` and `nui_right`.
    ///
    /// - parameter relationView:     The view on which you set right relation.
    /// - parameter inset:            The inset for additional space between views. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func right(to relationView: RelationView<HorizontalRelation>, inset: Number = 0.0) -> UIViewMaker {
        _right(to: relationView, inset: inset)
        return self
    }

    /// Creates center relation to superview.
    ///
    /// Use this method when you want to center view by both axis relativity superview.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func center() -> UIViewMaker {
        _center()
        return self
    }

    /// Creates center relation.
    ///
    /// Use this method when you want to center view by both axis relativity another view.
    ///
    /// - parameter view: The view on which you set center relation.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func center(to view: UIView) -> UIViewMaker {
        _center(to: view)
        return self
    }

    /// Creates center relation rotated around center of a specified view.
    ///
    /// Use this method when you want to center view by both axis relativity another view.
    ///
    /// - parameter view: The view on which you set center relation.
    /// - parameter radius: Radius of the arc on which center point will be placed.
    /// - parameter angle: Angle at which center point will be placed.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func center(to view: UIView, radius: CGFloat, angle: CGFloat) -> UIViewMaker {
        _center(to: view, radius: radius, angle: angle)
        return self
    }

    /// Creates centerY relation.
    ///
    /// Use this method when you want to join centerY of current view with centerY of superview.
    ///
    /// - parameter offset: Additional offset for centerY point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerY(offset: Number = 0.0) -> UIViewMaker {
        _centerY(offset: offset)
        return self
    }

    /// Creates centerY relation.
    ///
    /// Use this method when you want to join centerY of current view with some vertical side of another view.
    ///
    /// - note: You can not use this method with other relations except for `nui_top`, `nui_centerY` and `nui_bottom`.
    ///
    /// - parameter relationView:   The view on which you set centerY relation.
    /// - parameter offset:         Additional offset for centerY point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerY(to relationView: RelationView<VerticalRelation>, offset: Number = 0.0) -> UIViewMaker {
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

    @discardableResult public func centerY(between view1: UIView, _ view2: UIView) -> UIViewMaker {
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
                                           _ relationView2: RelationView<VerticalRelation>) -> UIViewMaker {
        _centerY(between: relationView1, relationView2)
        return self
    }

    /// Creates centerX relation to superview.
    ///
    /// Use this method when you want to join centerX of current view with centerX of superview.
    ///
    /// - parameter offset: Additional offset for centerX point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerX(offset: Number = 0.0) -> UIViewMaker {
        _centerX(offset: offset)
        return self
    }

    /// Creates centerX relation.
    ///
    /// Use this method when you want to join centerX of current view with some horizontal side of another view.
    ///
    /// - note: You can not use this method with other relations except for `nui_left`, `nui_centerX` and `nui_right`.
    ///
    /// - parameter relationView:   The view on which you set centerX relation.
    /// - parameter offset:         Additional offset for centerX point. Default value: 0.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func centerX(to relationView: RelationView<HorizontalRelation>, offset: Number = 0.0) -> UIViewMaker {
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

    @discardableResult public func centerX(between view1: UIView, _ view2: UIView) -> UIViewMaker {
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
                                           _ relationView2: RelationView<HorizontalRelation>) -> UIViewMaker {
        _centerX(between: relationView1, relationView2)
        return self
    }

    /// Just setting centerX.
    ///
    /// - parameter value: The value for setting centerX.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func setCenterX(value: Number) -> UIViewMaker {
        _setCenterX(value: value)
        return self
    }

    /// Just setting centerY.
    ///
    /// - parameter value: The value for setting centerY.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func setCenterY(value: Number) -> UIViewMaker {
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

    @discardableResult public func center(to layer: CALayer) -> UIViewMaker {
        _center(to: layer)
        return self
    }
}
