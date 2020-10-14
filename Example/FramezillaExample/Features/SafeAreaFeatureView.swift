//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class SafeAreaFeatureView: SliderFeatureView {

    var inset: CGFloat = 0

    override func performAddSubviews() {
        super.performAddSubviews()
        addSubview(purpleView)
    }

    override func performLayout() {
        super.performLayout()
        guard let superview = superview else {
            return
        }

        purpleView.configureFrame { maker in
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
