//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public extension Maker {

    func max<Relation>(_ lhs: RelationView<Relation>, _ rhs: RelationView<Relation>) -> RelationView<Relation> {
        let deltas = calculatedDeltas(between: lhs, and: rhs)
        let lhsDelta = deltas.lhsDelta
        let rhsDelta = deltas.rhsDelta
        return lhsDelta > rhsDelta ? lhs : rhs
    }

    func min<Relation>(_ lhs: RelationView<Relation>, _ rhs: RelationView<Relation>) -> RelationView<Relation> {
        let deltas = calculatedDeltas(between: lhs, and: rhs)
        let lhsDelta = deltas.lhsDelta
        let rhsDelta = deltas.rhsDelta
        return lhsDelta < rhsDelta ? lhs : rhs
    }

    private func calculatedDeltas<Relation>(between lhs: RelationView<Relation>,
                                            and rhs: RelationView<Relation>) -> (lhsDelta: CGFloat, rhsDelta: CGFloat) {

        let currentConvertedPoint = convertedValue(for: lhs.relationType, with: view)
        let lhsConvertedPoint = convertedValue(for: lhs.relationType, with: lhs.view)
        let rhsConvertedPoint = convertedValue(for: rhs.relationType, with: rhs.view)
        let lhsDelta = lhsConvertedPoint - currentConvertedPoint
        let rhsDelta = rhsConvertedPoint - currentConvertedPoint
        return (lhsDelta, rhsDelta)
    }
}
