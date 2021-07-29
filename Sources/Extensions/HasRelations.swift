//
//  UIView+Relations.swift
//  Framezilla
//
//  Created by Nikita on 26/08/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

import UIKit

public protocol HasElement {
    var element: ElementType { get }
}

public protocol HasRelations {
}

extension UIView: HasElement, HasRelations {
    public var element: ElementType {
        .view(self)
    }

    /// Safe area

    @available(iOS 11.0, *)
    public var nui_safeArea: SafeAreaRelationCollection {
        return SafeAreaRelationCollection(element: .view(self))
    }
}

extension CALayer: HasElement, HasRelations {
    public var element: ElementType {
        .layer(self)
    }
}
extension HasRelations where Self: HasElement {

    /// Width relation of current instance.

    public var nui_width: RelationView<SizeRelation> {
        return .init(element: element, relation: .width)
    }

    /// Height relation of current instance.

    public var nui_height: RelationView<SizeRelation> {
        return .init(element: element, relation: .height)
    }

    /// Left relation of current instance.

    public var nui_left: RelationView<HorizontalRelation> {
        return .init(element: element, relation: .left)
    }

    /// Right relation of current instance.

    public var nui_right: RelationView<HorizontalRelation> {
        return .init(element: element, relation: .right)
    }

    /// Top relation of current instance.

    public var nui_top: RelationView<VerticalRelation> {
        return .init(element: element, relation: .top)
    }

    /// Bottom relation of current instance.

    public var nui_bottom: RelationView<VerticalRelation> {
        return .init(element: element, relation: .bottom)
    }

    /// CenterX relation of current instance.

    public var nui_centerX: RelationView<HorizontalRelation> {
        return .init(element: element, relation: .centerX)
    }

    /// CenterY relation of current instance.

    public var nui_centerY: RelationView<VerticalRelation> {
        return .init(element: element, relation: .centerY)
    }
}
