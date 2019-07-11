//
//  RelationOperators.swift
//  Framezilla iOS
//
//  Created by Anton K on 13/06/2019.
//

import Foundation

public extension RelationView {

    private static func commonAncestor(_ lhs: UIView, _ rhs: UIView) -> UIView? {
        if lhs.superview == rhs.superview {
            return lhs.superview
        }
        else if lhs.window == rhs.window {
            return lhs.window
        }

        return UIApplication.shared.keyWindow
    }

    private static func pick<T>(_ lhs: RelationView<T>, _ rhs: RelationView<T>, comparator: (CGFloat, CGFloat) -> Bool) -> RelationView<T> {
        guard let view = commonAncestor(lhs.view, rhs.view) else {
            assertionFailure("No common ancestor")
            return lhs
        }

        let maker = Maker(view: view)
        let lValue = maker.convertedValue(for: lhs.relationType, with: lhs.view)
        let rValue = maker.convertedValue(for: rhs.relationType, with: rhs.view)

        if comparator(lValue, rValue) {
            return lhs
        }

        return rhs
    }

    static func min<T>(_ lhs: RelationView<T>, _ rhs: RelationView<T>) -> RelationView<T> {
        return pick(lhs, rhs, comparator: <)
    }

    static func max<T>(_ lhs: RelationView<T>, _ rhs: RelationView<T>) -> RelationView<T> {
        return pick(lhs, rhs, comparator: >)
    }
}
