//
//  MakerHelper.swift
//  Framezilla
//
//  Created by Nikita on 26/08/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

import Foundation

extension Maker {

    func convertedValue(for type: RelationType, with view: ViewType) -> CGFloat {
        var rect: CGRect {
            if let superview = self.view.superview, superview === view {
                return CGRect(origin: .zero, size: superview.frame.size)
            }

            if let superview = self.view.superview {
                return superview.convert(view.frame, from: view.superview)
            }
            assertionFailure("Can't configure a frame for view: \(self.view) without superview.")
            return .zero
        }

        var convertedRect = rect
        if case let .view(superview) = self.view.superview,
            case let .view(view) = view,
            let superScrollView = superview as? UIScrollView,
            view is UIScrollView,
            superScrollView.contentSize != .zero {
            convertedRect.size.width = superScrollView.contentSize.width
            convertedRect.size.height = superScrollView.contentSize.height
        }

        return value(for: type, with: view, in: convertedRect)
    }

    func value(for type: RelationType, with view: ViewType, in rect: CGRect) -> CGFloat {
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
            return rect.minY + view.safeAreaInsets.top
        case .safeArea(.left):
            return rect.minX + view.safeAreaInsets.left
        case .safeArea(.right):
            return rect.maxX - view.safeAreaInsets.right
        case .safeArea(.bottom):
            return rect.maxY - view.safeAreaInsets.bottom
        default:
            return 0
        }
    }

    func relationSize(view: ViewType, for type: RelationType) -> CGFloat {
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
