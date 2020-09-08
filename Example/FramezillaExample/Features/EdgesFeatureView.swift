//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class Feature {

    let title: String
    let description: String
    let featureView: UIView

    init(title: String, description: String, featureView: UIView) {
        self.title = title
        self.description = description
        self.featureView = featureView
    }
}

final class EdgesFeatureView: UIView {

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()

    private lazy var exampleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        containerView.addSubview(exampleView)
        addSubview(containerView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.frame = bounds

        exampleView.configureFrame { maker in
            maker.edges(insets: .init(top: 10, left: 20, bottom: 30, right: 40))
        }
    }
}
