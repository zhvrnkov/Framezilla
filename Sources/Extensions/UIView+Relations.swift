//
//  UIView+Relations.swift
//  Framezilla
//
//  Created by Nikita on 26/08/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

public extension UIView {

    /// Width relation of current view.

    var nui_width: RelationView<SizeRelation> {
        return RelationView(view: self, relation: .width)
    }

    /// Height relation of current view.

    var nui_height: RelationView<SizeRelation> {
        return RelationView<SizeRelation>(view: self, relation: .height)
    }

    /// Left relation of current view.

    var nui_left: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: self, relation: .left)
    }

    /// Right relation of current view.

    var nui_right: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: self, relation: .right)
    }

    /// Top relation of current view.

    var nui_top: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: self, relation: .top)
    }

    /// Bottom relation of current view.

    var nui_bottom: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: self, relation: .bottom)
    }

    /// CenterX relation of current view.

    var nui_centerX: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: self, relation: .centerX)
    }

    /// CenterY relation of current view.

    var nui_centerY: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: self, relation: .centerY)
    }

    /// Safe area

    @available(iOS 11.0, *)
    var nui_safeArea: SafeAreaRelationCollection {
        return SafeAreaRelationCollection(view: self)
    }
}
