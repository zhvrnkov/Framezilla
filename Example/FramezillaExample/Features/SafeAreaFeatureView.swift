//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class SafeAreaFeatureView: SliderFeatureView {

    private var inset: CGFloat = 0

    // MARK: - Lifecycle

    override func performAddSubviews() {
        super.performAddSubviews()
        addSubview(purpleView)
    }

    override func performLayout() {
        super.performLayout()

        purpleView.configureFrame { maker in
            guard let superview = superview else {
                return
            }
            maker.bottom(to: superview.nui_safeArea.bottom, inset: inset)
        }
    }

    override func sliderValueDidChange(_ slider: UISlider) {
        let maxInset = bounds.height - sliderValueLabel.frame.maxY - purpleView.frame.height
        inset = CGFloat(slider.value) * maxInset
        sliderValueLabel.text = "inset = \(inset)"
        setNeedsLayout()
        layoutIfNeeded()
    }
}
