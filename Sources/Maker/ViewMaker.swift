//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public final class ViewMaker: Maker {

    /// Resizes the current view so it just encloses its subviews.
    ///
    /// - returns: `Maker` instance for chaining relations.

    unowned let uiView: UIView

    init(view: UIView) {
        self.uiView = view
        super.init(element: .view(view))
    }

    /// Resizes the current view so it just encloses its subviews.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func sizeToFit() -> ViewMaker {
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

    @discardableResult public func sizeThatFits(size: CGSize) -> ViewMaker {
        let fitSize = uiView.sizeThatFits(size)
        let width = Swift.min(size.width, fitSize.width)
        let height = Swift.min(size.height, fitSize.height)
        setHighPriorityValue(width, for: .width)
        setHighPriorityValue(height, for: .height)
        return self
    }

    /// Resizes and moves the receiver view so it just encloses its subviews only for height.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func heightToFit() -> ViewMaker {
        return heightThatFits(maxHeight: CGFloat.greatestFiniteMagnitude)
    }

    /// Calculates the height that best fits the specified size.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func heightThatFits(maxHeight: Number) -> ViewMaker {
        let handler = { [unowned self] in
            let fitWidth: CGFloat

            if let parameter = self.widthParameter {
                fitWidth = parameter.value
            }
            else if let parameter = self.widthToParameter {
                fitWidth = self.relationSize(element: parameter.element, for: parameter.relationType) * parameter.value
            }
            else if let leftParameter = self.leftParameter, let rightParameter = self.rightParameter {
                let leftViewX = self.convertedValue(for: leftParameter.relationType, with: leftParameter.element) + leftParameter.value
                let rightViewX = self.convertedValue(for: rightParameter.relationType, with: rightParameter.element) - rightParameter.value

                fitWidth = rightViewX - leftViewX
            }
            else {
                fitWidth = .greatestFiniteMagnitude
            }

            let fitSize = self.uiView.sizeThatFits(CGSize(width: fitWidth, height: .greatestFiniteMagnitude))
            self.newRect.setValue(Swift.min(maxHeight.value, fitSize.height), for: .height)
        }
        handlers.append((.high, handler))
        return self
    }

    /// Resizes and moves the receiver view so it just encloses its subviews only for width.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func widthToFit() -> ViewMaker {
        return widthThatFits(maxWidth: CGFloat.greatestFiniteMagnitude)
    }

    /// Calculates the width that best fits the specified size.
    ///
    /// - returns: `Maker` instance for chaining relations.

    @discardableResult public func widthThatFits(maxWidth: Number) -> ViewMaker {
        let handler = { [unowned self] in
            let fitHeight: CGFloat

            if let parameter = self.heightParameter {
                fitHeight = parameter.value
            }
            else if let parameter = self.heightToParameter {
                fitHeight = self.relationSize(element: parameter.element, for: parameter.relationType) * parameter.value
            }
            else if let topParameter = self.topParameter, let bottomParameter = self.bottomParameter {
                let topViewY = self.convertedValue(for: topParameter.relationType, with: topParameter.element) + topParameter.value
                let bottomViewY = self.convertedValue(for: bottomParameter.relationType, with: bottomParameter.element) - bottomParameter.value

                fitHeight = bottomViewY - topViewY
            }
            else {
                fitHeight = .greatestFiniteMagnitude
            }

            let fitSize = self.uiView.sizeThatFits(CGSize(width: .greatestFiniteMagnitude, height: fitHeight))
            self.newRect.setValue(Swift.min(maxWidth.value, fitSize.width), for: .width)
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
    @discardableResult public func right(to safeArea: SafeArea, inset: Number = 0.0) -> ViewMaker {
        if #available(iOS 11.0, *) {
            guard let superelement = element.superelement as? ViewType else {
                assertionFailure("Can not configure a right relation to the safe area without superview.")
                return self
            }
            right(inset: superelement.safeAreaInsets.right + inset.value)
        }
        else {
            right(inset: inset)
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
    @discardableResult public func left(to safeArea: SafeArea, inset: Number = 0.0) -> ViewMaker {
        if #available(iOS 11.0, *) {
            guard let superelement = element.superelement as? ViewType else {
                assertionFailure("Can not configure a left relation to the safe area without superview.")
                return self
            }
            return left(inset: superelement.safeAreaInsets.left + inset.value)
        }
        else {
            return left(inset: inset)
        }
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
    @discardableResult public func top(to safeArea: SafeArea, inset: Number = 0.0) -> ViewMaker {
        if #available(iOS 11.0, *) {
            guard let superelement = element.superelement as? ViewType else {
                assertionFailure("Can not configure a top relation to the safe area without superview.")
                return self
            }
            return top(inset: superelement.safeAreaInsets.top + inset.value)
        }
        else {
            return top(inset: inset)
        }
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
    @discardableResult public func bottom(to safeArea: SafeArea, inset: Number = 0.0) -> ViewMaker {
        if #available(iOS 11.0, *) {
            guard let superelement = element.superelement as? ViewType else {
                assertionFailure("Can not configure a bottom relation to the safe area without superview.")
                return self
            }
            return bottom(inset: superelement.safeAreaInsets.bottom + inset.value)
        }
        else {
            return bottom(inset: inset)
        }
    }
}
