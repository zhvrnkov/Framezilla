//
//  MakerHelper.swift
//  Framezilla
//
//  Created by Nikita on 26/08/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

import Foundation

fileprivate extension UIView {

    func contains(_ view: UIView) -> Bool {
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
}

extension Maker {

    func convertedValue(for type: RelationType, with view: UIView) -> CGFloat {
        var rect: CGRect {
            if let superview = self.view.superview, superview === view {
                return CGRect(origin: .zero, size: superview.frame.size)
            }

            if let supervew = self.view.superview {
                return supervew.convert(view.frame, from: view.superview)
            }
            assertionFailure("Can't configure a frame for view: \(self.view) without superview.")
            return .zero
        }

        var convertedRect = rect
        if let superScrollView = self.view.superview as? UIScrollView, view is UIScrollView, superScrollView.contentSize != .zero {
            convertedRect.size.width = superScrollView.contentSize.width
            convertedRect.size.height = superScrollView.contentSize.height
        }

        return value(for: type, with: view, in: convertedRect)
    }

    func value(for type: RelationType, with view: UIView, in rect: CGRect) -> CGFloat {
        switch type {
        case .top:
            return rect.minY
        case .bottom:
            return rect.maxY
        case .centerY:
            return view.contains(self.view) ? rect.height / 2 : rect.midY
        case .centerX:
            return view.contains(self.view) ? rect.width / 2 : rect.midX
        case .right:
            return rect.maxX
        case .left:
            return rect.minX
        case .safeArea(.top):
            if #available(iOS 11.0, *) {
                return rect.minY + view.safeAreaInsets.top
            }

            return rect.minY
        case .safeArea(.left):
            if #available(iOS 11.0, *) {
                return rect.minX + view.safeAreaInsets.left
            }

            return rect.minX
        case .safeArea(.right):
            if #available(iOS 11.0, *) {
                return rect.maxX - view.safeAreaInsets.right
            }

            return rect.maxX
        case .safeArea(.bottom):
            if #available(iOS 11.0, *) {
                return rect.maxY - view.safeAreaInsets.bottom
            }

            return rect.maxY
        default:
            return 0
        }
    }

    func relationSize(view: UIView, for type: RelationType) -> CGFloat {
        switch type {
        case .width:  return view.bounds.width
        case .height: return view.bounds.height
        default:      return 0
        }
    }
}

extension CGRect {

    mutating func setValue(_ value: CGFloat, for type: RelationType) {
        var frame = self
        switch type {
        case .width:   frame.size.width = value
        case .height:  frame.size.height = value
        case .left:    frame.origin.x = value
        case .top:     frame.origin.y = value
        case .centerX: frame.origin.x = value - width/2
        case .centerY: frame.origin.y = value - height/2
        default: break
        }
        self = frame
    }
}
