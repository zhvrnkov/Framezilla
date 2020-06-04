//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

extension Maker {

    func _edges(top: Number? = nil, left: Number? = nil, bottom: Number? = nil, right: Number? = nil) {
        apply(self._top, top)
        apply(self._left, left)
        apply(self._bottom, bottom)
        apply(self._right, right)
    }

    func _edges(insets: UIEdgeInsets, sides: Sides = .all) {
        sides.forEach { side in
            switch side {
            case .bottom:
                _bottom(inset: insets.bottom)
            case .left:
                _left(inset: insets.left)
            case .right:
                _right(inset: insets.right)
            case .top:
                _top(inset: insets.top)
            default:
                return
            }
        }
    }
}
