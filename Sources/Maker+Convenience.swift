//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public extension Maker {

    func maxRelation<Relation>(_ lhs: RelationView<Relation>, _ rhs: RelationView<Relation>) -> RelationView<Relation> {
        let lhsConvertedValue = convertedValue(for: lhs)
        let rhsConvertedValue = convertedValue(for: rhs)
        return lhsConvertedValue > rhsConvertedValue ? lhs : rhs
    }

    func minRelation<Relation>(_ lhs: RelationView<Relation>, _ rhs: RelationView<Relation>) -> RelationView<Relation> {
        let lhsConvertedValue = convertedValue(for: lhs)
        let rhsConvertedValue = convertedValue(for: rhs)
        return lhsConvertedValue < rhsConvertedValue ? lhs : rhs
    }

    private func convertedValue<Relation>(for relation: RelationView<Relation>) -> CGFloat {
        if relation.relationType.isSizeType {
            return relationSize(view: relation.view, for: relation.relationType)
        }
        else {
            return convertedValue(for: relation.relationType, with: relation.view)
        }
    }
}
