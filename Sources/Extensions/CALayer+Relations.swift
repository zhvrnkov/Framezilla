//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public extension CALayer {

    /// Width relation of current layer.

    var nui_width: RelationView<SizeRelation> {
        return RelationView(view: .layer(self), relation: .width)
    }

    /// Height relation of current layer.

    var nui_height: RelationView<SizeRelation> {
        return RelationView<SizeRelation>(view: .layer(self), relation: .height)
    }

    /// Left relation of current layer.

    var nui_left: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: .layer(self), relation: .left)
    }

    /// Right relation of current layer.

    var nui_right: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: .layer(self), relation: .right)
    }

    /// Top relation of current layer.

    var nui_top: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: .layer(self), relation: .top)
    }

    /// Bottom relation of current layer.

    var nui_bottom: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: .layer(self), relation: .bottom)
    }

    /// CenterX relation of current layer.

    var nui_centerX: RelationView<HorizontalRelation> {
        return RelationView<HorizontalRelation>(view: .layer(self), relation: .centerX)
    }

    /// CenterY relation of current layer.

    var nui_centerY: RelationView<VerticalRelation> {
        return RelationView<VerticalRelation>(view: .layer(self), relation: .centerY)
    }
}