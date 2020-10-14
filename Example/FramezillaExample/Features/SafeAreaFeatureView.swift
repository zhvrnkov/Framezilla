//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class SafeAreaFeatureView: FeatureView {

    var inset: CGFloat = 0

    private lazy var sliderView: UISlider = {
        let view = UISlider()
        view.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        return view
    }()

    private lazy var insetLabel: UILabel = {
        let view = UILabel()
        view.text = "inset = 0"
        return view
    }()

    override func performAddSubviews() {
        addSubview(purpleView)
        addSubview(sliderView)
        addSubview(insetLabel)
    }

    override func performLayout() {
        guard let superview = superview else {
            return
        }

        sliderView.configureFrame { maker in
            maker.centerX().top(inset: 10).width(bounds.width - 30)
        }

        insetLabel.configureFrame { maker in
            maker.centerX().top(to: sliderView.nui_bottom).sizeToFit()
        }

        purpleView.configureFrame { maker in
            maker.bottom(to: superview.nui_safeArea.bottom, inset: inset)
        }
    }

    @objc private func sliderValueDidChange(_ slider: UISlider) {
        inset = CGFloat(slider.value) * purpleView.frame.height
        insetLabel.text = "inset = \(inset)"
        setNeedsLayout()
        layoutIfNeeded()
    }
}
