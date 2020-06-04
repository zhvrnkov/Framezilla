//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

extension Maker {

    func _equal(to view: UIView, insets: UIEdgeInsets = .zero) {
        equal(to: .view(view), insets: insets)
    }

    func _equal(to layer: CALayer, insets: UIEdgeInsets = .zero) {
        equal(to: .layer(layer), insets: insets)
    }

    private func equal(to view: ViewType, insets: UIEdgeInsets = .zero) {
        let topView = RelationView<VerticalRelation>(view: view, relation: .top)
        let leftView = RelationView<HorizontalRelation>(view: view, relation: .left)
        let bottomView = RelationView<VerticalRelation>(view: view, relation: .bottom)
        let rightView = RelationView<HorizontalRelation>(view: view, relation: .right)
        
        _top(to: topView, inset: insets.top)
        _left(to: leftView, inset: insets.left)
        _bottom(to: bottomView, inset: insets.bottom)
        _right(to: rightView, inset: insets.right)
    }
}
