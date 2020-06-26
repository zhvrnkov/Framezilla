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

    var element: ElementType
    var relationType: RelationType

    init(element: ElementType, relation: RelationType) {
        self.element = element
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
    var element: ElementType

    public lazy var top: RelationView<VerticalRelation> = .init(element: element, relation: .top)
    public lazy var left: RelationView<HorizontalRelation> = .init(element: element, relation: .left)
    public lazy var right: RelationView<HorizontalRelation> = .init(element: element, relation: .right)
    public lazy var bottom: RelationView<VerticalRelation> = .init(element: element, relation: .bottom)

    init(element: ElementType) {
        self.element = element
    }
}
