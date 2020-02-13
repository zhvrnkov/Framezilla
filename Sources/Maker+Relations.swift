//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public extension Maker {

    /// Finds relation with max value
    ///
    /// Use this method when you want to find relation with max value.
    ///
    /// - parameter lhs:   The left hand side relation to campare.
    /// - parameter rhs:   The right hand side relation to campare.
    ///
    /// - returns: `RelationView<Relation>` relation with max value between `lhs`and `rhs`.

    func maxRelation<Relation>(_ lhs: RelationView<Relation>, _ rhs: RelationView<Relation>) -> RelationView<Relation> {
        let lhsConvertedValue = convertedValue(for: lhs)
        let rhsConvertedValue = convertedValue(for: rhs)
        return lhsConvertedValue > rhsConvertedValue ? lhs : rhs
    }

    /// Finds relation with min value
    ///
    /// Use this method when you want to find relation with min value.
    ///
    /// - parameter lhs:   The left hand side relation to campare.
    /// - parameter rhs:   The right hand side relation to campare.
    ///
    /// - returns: `RelationView<Relation>` relation with min value between `lhs`and `rhs`.

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
