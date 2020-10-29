//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class MinMaxFeatureView: SliderFeatureView {

    private var greenViewLeftInset: CGFloat = 0
    private var pinkViewLeftInset: CGFloat = 70

    private let viewSize: CGSize = .init(width: 100, height: 100)

    // MARK: - Lifecycle

    override func performAddSubviews() {
        super.performAddSubviews()
        sliderValueLabel.text = "Green view left inset = 0"
    }

    override func performLayout() {
        super.performLayout()

        greenView.configureFrame { maker in
            maker.left(inset: greenViewLeftInset).centerY(offset: viewSize.height / 2).size(viewSize)
        }
        pinkView.configureFrame { maker in
            maker.left(inset: pinkViewLeftInset).centerY(offset: -viewSize.height / 2).size(viewSize)
        }
        purpleView.configureFrame { maker in
            let leftRelation = maker.max(greenView.nui_right, pinkView.nui_right)
            maker.left(to: leftRelation).centerY().size(viewSize)
        }
    }

    override func sliderValueDidChange(_ slider: UISlider) {
        greenViewLeftInset = CGFloat(slider.value) * (bounds.width - (viewSize.width * 2))
        sliderValueLabel.text = "Green view left inset = \(greenViewLeftInset)"
        setNeedsLayout()
        layoutIfNeeded()
    }
}
