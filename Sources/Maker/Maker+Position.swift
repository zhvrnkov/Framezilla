//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

extension Maker {

    func _left(inset: Number = 0.0) {
        guard let superview = view.layout.superview else {
            assertionFailure("Can not configure left relation to superview without superview.")
            return
        }
        _left(to: RelationView(view: superview, relation: .left), inset: inset)
    }

    func _left(to relationView: RelationView<HorizontalRelation>, inset: Number = 0.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            let x = self.convertedValue(for: relationType, with: view) + inset.value
            self.newRect.setValue(x, for: .left)
        }
        handlers.append((.high, handler))
        leftParameter = SideParameter(view: view, value: inset.value, relationType: relationType)
    }

    func _top(inset: Number = 0.0) {
        guard let superview = view.layout.superview else {
            assertionFailure("Can not configure a top relation to superview without superview.")
            return
        }
        _top(to: RelationView(view: superview, relation: .top), inset: inset.value)
    }

    func _top(to safeArea: SafeArea, inset: Number = 0.0) {
        if #available(iOS 11.0, *) {
            guard let superview = view.layout.superview,
                let layout = superview.layout as? UIViewLayout else {
                assertionFailure("Can not configure a top relation to the safe area without superview.")
                return
            }
            _top(inset: layout.safeAreaInsets.top + inset.value)
            return
        }
        _top(inset: inset)
    }

    func _top(to relationView: RelationView<VerticalRelation>, inset: Number = 0.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            let y = self.convertedValue(for: relationType, with: view) + inset.value
            self.newRect.setValue(y, for: .top)
        }
        handlers.append((.high, handler))
        topParameter = SideParameter(view: view, value: inset.value, relationType: relationType)
    }

    func _margin(_ inset: Number) {
        let inset = inset.value
        _edges(insets: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }

    func _bottom(inset: Number = 0.0) {
        guard let superview = view.layout.superview else {
            assertionFailure("Can not configure a bottom relation to superview without superview.")
            return
        }
        _bottom(to: RelationView(view: superview, relation: .bottom), inset: inset)
    }

    func _bottom(to safeArea: SafeArea, inset: Number = 0.0) {
        if #available(iOS 11.0, *) {
            guard let superview = view.layout.superview,
                let layout = superview.layout as? UIViewLayout else {
                assertionFailure("Can not configure a bottom relation to the safe area without superview.")
                return
            }
            _bottom(inset: layout.safeAreaInsets.bottom + inset.value)
            return
        }
        _bottom(inset: inset)
    }

    func _bottom(to relationView: RelationView<VerticalRelation>, inset: Number = 0.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            if self.topParameter != nil {
                let height = abs(self.newRect.minY - self.convertedValue(for: relationType, with: view)) - inset.value
                self.newRect.setValue(height, for: .height)
            }
            else {
                let y = self.convertedValue(for: relationType, with: view) - inset.value - self.newRect.height
                self.newRect.setValue(y, for: .top)
            }
        }
        handlers.append((.middle, handler))
        bottomParameter = SideParameter(view: view, value: inset.value, relationType: relationType)
    }

    func _right(inset: Number = 0.0) {
        guard let superview = view.layout.superview else {
            assertionFailure("Can not configure a right relation to superview without superview.")
            return
        }
        _right(to: RelationView(view: superview, relation: .right), inset: inset.value)
    }

    func _right(to relationView: RelationView<HorizontalRelation>, inset: Number = 0.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            if self.leftParameter != nil {
                let width = abs(self.newRect.minX - self.convertedValue(for: relationType, with: view)) - inset.value
                self.newRect.setValue(width, for: .width)
            }
            else {
                let x = self.convertedValue(for: relationType, with: view) - inset.value - self.newRect.width
                self.newRect.setValue(x, for: .left)
            }
        }
        handlers.append((.middle, handler))
        rightParameter = SideParameter(view: view, value: inset.value, relationType: relationType)
    }

    func _center() {
        guard let superview = view.layout.superview else {
            assertionFailure("Can not configure a center relation to superview without superview.")
            return
        }
        switch superview {
        case .view(let view):
            _center(to: view)
        case .layer(let layer):
            _center(to: layer)
        }
    }

    func _center(to view: UIView) {
        _centerX(to: RelationView<HorizontalRelation>(view: .view(view), relation: .centerX))
        _centerY(to: RelationView<VerticalRelation>(view: .view(view), relation: .centerY))
    }

    func _center(to view: UIView, radius: CGFloat, angle: CGFloat) {
        let offsetX = -radius * cos(-angle)
        let offsetY = radius * sin(-angle)
        _centerX(to: RelationView<HorizontalRelation>(view: .view(view), relation: .centerX), offset: offsetX)
        _centerY(to: RelationView<VerticalRelation>(view: .view(view), relation: .centerY), offset: offsetY)
    }

    func _centerY(offset: Number = 0.0) {
        guard let superview = view.layout.superview else {
            assertionFailure("Can not configure a centerY relation to superview without superview.")
            return
        }
        _centerY(to: RelationView(view: superview, relation: .centerY), offset: offset.value)
    }

    func _centerY(to relationView: RelationView<VerticalRelation>, offset: Number = 0.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            let y = self.convertedValue(for: relationType, with: view) - self.newRect.height/2 - offset.value
            self.newRect.setValue(y, for: .top)
        }
        handlers.append((.low, handler))
    }

    func _centerY(between view1: UIView, _ view2: UIView) {
        let topView = view1.frame.maxY > view2.frame.minY ? view2 : view1
        let bottomView = topView === view1 ? view2 : view1
        _centerY(between: topView.nui_bottom, bottomView.nui_top)
    }

    func _centerY(between relationView1: RelationView<VerticalRelation>, _ relationView2: RelationView<VerticalRelation>) {
        let view1 = relationView1.view
        let view2 = relationView2.view

        let relationType1 = relationView1.relationType
        let relationType2 = relationView2.relationType

        let handler = { [unowned self] in
            let y1 = self.convertedValue(for: relationType1, with: view1)
            let y2 = self.convertedValue(for: relationType2, with: view2)

            let topY = y1 < y2 ? y1 : y2
            let bottomY = y1 >= y2 ? y1 : y2

            let y = bottomY - (bottomY - topY)/2 - self.newRect.height/2
            self.newRect.setValue(y, for: .top)
        }
        handlers.append((.low, handler))
    }

    func _centerX(offset: Number = 0.0) {
        guard let superview = view.layout.superview else {
            assertionFailure("Can not configure a centerX relation to superview without superview.")
            return
        }
        _centerX(to: RelationView(view: superview, relation: .centerX), offset: offset.value)
    }

    func _centerX(to relationView: RelationView<HorizontalRelation>, offset: Number = 0.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            let x = self.convertedValue(for: relationType, with: view) - self.newRect.width/2 - offset.value
            self.newRect.setValue(x, for: .left)
        }
        handlers.append((.low, handler))
    }

    func _centerX(between view1: UIView, _ view2: UIView) {
        let leftView = view1.frame.maxX > view2.frame.minX ? view2 : view1
        let rightView = leftView === view1 ? view2 : view1
        _centerX(between: leftView.nui_right, rightView.nui_left)
    }

    func _centerX(between relationView1: RelationView<HorizontalRelation>, _ relationView2: RelationView<HorizontalRelation>) {
        let view1 = relationView1.view
        let view2 = relationView2.view

        let relationType1 = relationView1.relationType
        let relationType2 = relationView2.relationType

        let handler = { [unowned self] in
            let x1 = self.convertedValue(for: relationType1, with: view1)
            let x2 = self.convertedValue(for: relationType2, with: view2)

            let rightX = x1 < x2 ? x1 : x2
            let leftX = x1 >= x2 ? x1 : x2

            let x = rightX - (rightX - leftX)/2 - self.newRect.width/2
            self.newRect.setValue(x, for: .left)
        }
        handlers.append((.low, handler))
    }

    func _setCenterX(value: Number) {
        let handler = { [unowned self] in
            self.newRect.setValue(value.value, for: .centerX)
        }
        handlers.append((.low, handler))
    }

    func _setCenterY(value: Number) {
        let handler = { [unowned self] in
            self.newRect.setValue(value.value, for: .centerY)
        }
        handlers.append((.low, handler))
    }

    func _center(to layer: CALayer) {
        _centerX(to: RelationView<HorizontalRelation>(view: .layer(layer), relation: .centerX))
        _centerY(to: RelationView<VerticalRelation>(view: .layer(layer), relation: .centerY))
    }
}
