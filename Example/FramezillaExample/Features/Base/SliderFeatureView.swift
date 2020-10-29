//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

class SliderFeatureView: FeatureView {

    // MARK: - Subviews

    private(set) lazy var sliderView: UISlider = {
        let view = UISlider()
        view.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        return view
    }()

    private(set) lazy var sliderValueLabel: UILabel = {
        let view = UILabel()
        view.text = "value = 0"
        return view
    }()

    // MARK: - Lifecycle

    override func performAddSubviews() {
        super.performAddSubviews()
        addSubview(sliderView)
        addSubview(sliderValueLabel)
    }

    override func performLayout() {
        sliderView.configureFrame { maker in
            maker.centerX().top(inset: 10).width(bounds.width - 30)
        }

        sliderValueLabel.configureFrame { maker in
            maker.centerX().top(to: sliderView.nui_bottom).sizeToFit()
        }
    }


    @objc func sliderValueDidChange(_ slider: UISlider) {

    }
}
