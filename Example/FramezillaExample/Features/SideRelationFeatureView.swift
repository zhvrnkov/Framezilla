//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class SideRelationFeatureView: FeatureView {

    // MARK: - Lifecycle

    override func performLayout() {
        greenView.configureFrame { maker in
            maker.bottom(to: purpleView.nui_top, inset: 20)
                .top()
                .left(to: purpleView.nui_left)
                .right(to: purpleView.nui_centerX)
        }

        pinkView.configureFrame { maker in
            maker.top(to: purpleView.nui_bottom, inset: 20)
                .left(to: greenView.nui_right)
                .right(to: purpleView.nui_right)
                .bottom()
        }
    }
}
