//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

private var layoutAssociationKey = "layout_association_key"

public enum ViewType {
    case view(UIView)
    case layer(CALayer)
}

extension ViewType {

    var layout: Layout {
        if let value = objc_getAssociatedObject(self, &layoutAssociationKey) as? Layout {
            return value
        }
        else {
            let layout: Layout
            switch self {
            case .view(let view):
                layout = UIViewLayout(view: view)
            case .layer(let layer):
                layout = CALayerLayout(layer: layer)
            }
            objc_setAssociatedObject(self, &layoutAssociationKey, layout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return layout
        }
    }
}

extension ViewType: Equatable {
    public static func == (lhs: ViewType, rhs: ViewType) -> Bool {
        switch (lhs, rhs) {
        case (.view(let lhs), .view(let rhs)):
            return lhs == rhs
        case (.layer(let lhs), .layer(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }

    public static func === (lhs: ViewType, rhs: ViewType) -> Bool {
        switch (lhs, rhs) {
        case (.view(let lhs), .view(let rhs)):
            return lhs === rhs
        case (.layer(let lhs), .layer(let rhs)):
            return lhs === rhs
        default:
            return false
        }
    }
}

protocol Layout: class {
    var superview: ViewType? { get }
    var subviews: [ViewType] { get }
    var frame: CGRect { get set}
    var bounds: CGRect { get set}
    var cornerRadius: CGFloat { get set}

    func contains(_ view: ViewType) -> Bool
    func convert(_ rect: CGRect, from view: ViewType?) -> CGRect
}

extension Layout {
    func contains(_ view: ViewType) -> Bool {
        if subviews.contains(view) {
            return true
        }
        for subview in subviews {
            if subview.layout.contains(view) {
                return true
            }
        }
        return false
    }
}

final class UIViewLayout: Layout {
    unowned let view: UIView

    var nx_state: AnyHashable {
        get {
            view.nx_state
        }
        set {
            view.nx_state = newValue
        }
    }

    var superview: ViewType? {
        guard let superview = view.superview else {
            return nil
        }
        return .view(superview)
    }

    var subviews: [ViewType] {
        return view.subviews.map { view in
            .view(view)
        }
    }

    var frame: CGRect {
        get {
            view.frame
        }
        set {
            view.frame = newValue
        }
    }

    var bounds: CGRect {
        get {
            view.bounds
        }
        set {
            view.bounds = newValue
        }
    }

    var cornerRadius: CGFloat {
        get {
            view.layer.cornerRadius
        }
        set {
            view.layer.cornerRadius = newValue
        }
    }

    func convert(_ rect: CGRect, from view: ViewType?) -> CGRect {
        guard let view = view else {
            return self.view.convert(rect, from: nil)
        }
        switch view {
        case let .view(view):
            return self.view.convert(rect, from: view)
        case let .layer(layer):
            return self.view.layer.convert(rect, from: layer)
        }
    }

    func sizeToFit() {
        view.sizeToFit()
    }

    func sizeThatFits(_ size: CGSize) -> CGSize {
        view.sizeThatFits(size)
    }

    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        }
        return .zero
    }

    init(view: UIView) {
        self.view = view
    }
}

final class CALayerLayout: Layout {
    unowned let layer: CALayer

    var superview: ViewType? {
        guard let superlayer = layer.superlayer else {
            return nil
        }
        return .layer(superlayer)
    }

    var subviews: [ViewType] {
        return layer.sublayers?.map { layer in
            .layer(layer)
        } ?? []
    }

    var frame: CGRect {
        get {
            layer.frame
        }
        set {
            layer.frame = newValue
        }
    }

    var bounds: CGRect {
        get {
            layer.bounds
        }
        set {
            layer.bounds = newValue
        }
    }

    var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    func convert(_ rect: CGRect, from view: ViewType?) -> CGRect {
        guard let view = view else {
            return self.layer.convert(rect, from: nil)
        }
        switch view {
        case let .view(view):
            return self.layer.convert(rect, from: view.layer)
        case let .layer(layer):
            return self.layer.convert(rect, from: layer)
        }
    }

    init(layer: CALayer) {
        self.layer = layer
    }
}
