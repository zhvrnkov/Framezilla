//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public enum ViewType {
    case view(UIView)
    case layer(CALayer)
}

extension ViewType {

    var subviews: [ViewType] {
        switch self {
        case .view(let view):
            return view.subviews.map { view in
                .view(view)
            }
        case .layer(let layer):
            return layer.sublayers?.map { layer in
                .layer(layer)
            } ?? []
        }
    }

    var frame: CGRect {
        get {
            switch self {
            case .view(let view):
                return view.frame
            case .layer(let layer):
                return layer.frame
            }
        }
        set {
            switch self {
            case .view(let view):
                view.frame = newValue
            case .layer(let layer):
                layer.frame = newValue
            }
        }
    }

    var bounds: CGRect {
        switch self {
        case .view(let view):
            return view.bounds
        case .layer(let layer):
            return layer.bounds
        }
    }

    var safeAreaInsets: UIEdgeInsets {
        switch self {
        case .view(let view):
            if #available(iOS 11.0, *) {
                return view.safeAreaInsets
            }
            return .zero
        case .layer:
            return .zero
        }
    }

    var superview: ViewType? {
        switch self {
        case .view(let view):
            guard let superview = view.superview else {
                return nil
            }
            return .view(superview)
        case .layer(let layer):
            guard let superlayer = layer.superlayer else {
                return nil
            }
            return .layer(superlayer)
        }
    }

    func contains(_ view: ViewType) -> Bool {
        if subviews.contains(view) {
            return true
        }
        for subview in subviews {
            if subview.contains(view) {
                return true
            }
        }
        return false
    }

    var nx_state: AnyHashable {
        get {
            switch self {
            case .view(let view):
                return view.nx_state
            case .layer(let layer):
                return layer.nx_state
            }
        }
        set {
            switch self {
            case .view(let view):
                view.nx_state = newValue
            case .layer(let layer):
                layer.nx_state = newValue
            }
        }
    }

    var cornerRadius: CGFloat {
        get {
            switch self {
            case .view(let view):
                return view.layer.cornerRadius
            case .layer(let layer):
                return layer.cornerRadius
            }
        }
        set {
            switch self {
            case .view(let view):
                view.layer.cornerRadius = newValue
            case .layer(let layer):
                layer.cornerRadius = newValue
            }
        }
    }

    func sizeThatFits(_ size: CGSize) -> CGSize {
        switch self {
        case .view(let view):
            return view.sizeThatFits(size)
        case .layer(let layer):
            return layer.bounds.size
        }
    }

    func sizeToFit() {
        switch self {
        case .view(let view):
            view.sizeToFit()
        default:
            return
        }
    }

    func convert(_ rect: CGRect, from view: ViewType?) -> CGRect {
        guard let view = view else {
            switch self {
            case .view(let view):
                return view.convert(rect, from: nil)
            case .layer(let layer):
                return layer.convert(rect, from: nil)
            }
        }
        switch (self, view) {
        case let (.view(superview), .view(view)):
            return superview.convert(rect, from: view)
        case let (.layer(superlayer), .layer(layer)):
            return superlayer.convert(rect, from: layer)
        case let (.layer(superlayer), .view(view)):
            return superlayer.convert(rect, from: view.layer)
        case let (.view(superview), .layer(layer)):
            return superview.layer.convert(rect, from: layer)
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
