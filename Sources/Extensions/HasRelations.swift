//
//  UIView+Relations.swift
//  Framezilla
//
//  Created by Nikita on 26/08/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

public protocol HasViewType {
    var viewType: ViewType { get }
}

public protocol HasRelations {
}

extension UIView: HasViewType, HasRelations {
    public var viewType: ViewType {
        .view(self)
    }

    /// Safe area

    @available(iOS 11.0, *)
    public var nui_safeArea: SafeAreaRelationCollection {
        return SafeAreaRelationCollection(view: .view(self))
    }
}

extension CALayer: HasViewType, HasRelations {
    public var viewType: ViewType {
        .layer(self)
    }
}
extension HasRelations where Self: HasViewType {

    /// Width relation of current instance.

    public var nui_width: RelationView<SizeRelation> {
        return RelationView(view: viewType, relation: .width)
    }

    /// Height relation of current instance.

    public var nui_height: RelationView<SizeRelation> {
        return RelationView<SizeRelation>(view: viewType, relation: .height)
    }

    /// Left relation of current instance.

    public var nui_left: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: viewType, relation: .left)
    }

    /// Right relation of current instance.

    public var nui_right: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: viewType, relation: .right)
    }

    /// Top relation of current instance.

    public var nui_top: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: viewType, relation: .top)
    }

    /// Bottom relation of current instance.

    public var nui_bottom: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: viewType, relation: .bottom)
    }

    /// CenterX relation of current instance.

    public var nui_centerX: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: viewType, relation: .centerX)
    }

    /// CenterY relation of current instance.

    public var nui_centerY: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: viewType, relation: .centerY)
    }
}
