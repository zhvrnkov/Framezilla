//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit
import Framezilla

final class ArcCenterFeature: SliderFeatureView {

    private var angle: CGFloat = 0

    // MARK: - Subviews

    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.anchorPoint = .init(x: 0, y: 0)
        return view
    }()

    // MARK: - Lifecycle
    
    override func performAddSubviews() {
        super.performAddSubviews()
        addSubview(lineView)
    }

    override func performLayout() {
        super.performLayout()

        purpleView.configureFrame { maker in
            let side = bounds.width / 2
            maker.center().size(width: side, height: side).cornerRadius(byHalf: .height)
        }

        greenView.configureFrame { maker in
            let side = 50
            maker.center(to: purpleView, radius: purpleView.bounds.width / 2, angle: angle)
                .size(width: side, height: side)
        }

        lineView.bounds = .init(origin: .zero, size: .init(width: purpleView.bounds.width / 2, height: 1))
        lineView.center = .init(x: purpleView.center.x, y: purpleView.center.y)
    }

    override func sliderValueDidChange(_ slider: UISlider) {
        angle = 2 * .pi * CGFloat(slider.value)
        sliderValueLabel.text = "angle = \(angle * 180 / .pi)"

        setNeedsLayout()
        layoutIfNeeded()
        lineView.transform = CGAffineTransform.identity.rotated(by: angle)
    }
}
