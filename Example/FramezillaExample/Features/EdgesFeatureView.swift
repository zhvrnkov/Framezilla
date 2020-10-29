//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class EdgesFeatureView: FeatureView {

    // MARK: - Lifecycle

    override func performAddSubviews() {
        purpleView.addSubview(greenView)
        addSubview(purpleView)
    }

    override func performLayout() {
        greenView.configureFrame { maker in
            maker.edges(insets: .init(top: 10, left: 20, bottom: 30, right: 40))
        }
    }
}
