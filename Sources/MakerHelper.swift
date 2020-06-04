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
            if let superview = self.view.layout.superview, superview === view {
                return CGRect(origin: .zero, size: superview.layout.frame.size)
            }

            if let superview = self.view.layout.superview {
                return superview.layout.convert(view.layout.frame, from: view.layout.superview)
            }
            assertionFailure("Can't configure a frame for view: \(self.view) without superview.")
            return .zero
        }

        var convertedRect = rect
        if case let .view(superview) = self.view.layout.superview,
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
            return view.layout.contains(self.view) ? rect.height / 2 : rect.midY
        case .centerX:
            return view.layout.contains(self.view) ? rect.width / 2 : rect.midX
        case .right:
            return rect.maxX
        case .left:
            return rect.minX
        case .safeArea(.top):
            if let layout = view.layout as? UIViewLayout {
                return rect.minY + layout.safeAreaInsets.top
            }
            return rect.minY
        case .safeArea(.left):
            if let layout = view.layout as? UIViewLayout {
                return rect.minX + layout.safeAreaInsets.left
            }
            return rect.minX
        case .safeArea(.right):
            if let layout = view.layout as? UIViewLayout {
                return rect.maxX - layout.safeAreaInsets.right
            }
            return rect.maxX
        case .safeArea(.bottom):
            if let layout = view.layout as? UIViewLayout {
                return rect.maxY - layout.safeAreaInsets.bottom
            }
            return rect.maxY
        default:
            return 0
        }
    }

    func relationSize(view: ViewType, for type: RelationType) -> CGFloat {
        switch type {
        case .width:  return view.layout.bounds.width
        case .height: return view.layout.bounds.height
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
