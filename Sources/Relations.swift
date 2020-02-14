//
//  Copyright © 2019 Rosberry. All rights reserved.
//

import UIKit

/// Phantom type for `nui_left`, `nui_right`, `nui_centerX` relations.

public protocol HorizontalRelation {}

/// Phantom type for `nui_top`, `nui_bottom`, `nui_centerY` relations.

public protocol VerticalRelation {}

/// Phantom type for `nui_height`, `nui_width` relations.

public protocol SizeRelation {}

public final class RelationView<Relation> {

    unowned var view: UIView
    var relationType: RelationType

    init(view: UIView, relation: RelationType) {
        self.view = view
        self.relationType = relation
    }
}

enum SafeAreaType {
    case top
    case left
    case right
    case bottom
}

enum RelationType {
    case bottom
    case top
    case left
    case right
    case width
    case widthTo
    case height
    case heightTo
    case centerX
    case centerY
    case safeArea(SafeAreaType)
}

extension RelationType {
    var isSizeType: Bool {
        switch self {
            case .width, .widthTo, .height, .heightTo:
                return true
            default:
                return false
        }
    }
}

public enum ContainerRelation {
    case width(Number)
    case height(Number)
    case horizontal(left: Number, right: Number)
    case vertical(top: Number, bottom: Number)
}

public class EdgeRelationCollection {
    unowned var view: UIView

    public lazy var top: RelationView<VerticalRelation> = .init(view: view, relation: .top)
    public lazy var left: RelationView<HorizontalRelation> = .init(view: view, relation: .left)
    public lazy var right: RelationView<HorizontalRelation> = .init(view: view, relation: .right)
    public lazy var bottom: RelationView<VerticalRelation> = .init(view: view, relation: .bottom)

    init(view: UIView) {
        self.view = view
    }
}
