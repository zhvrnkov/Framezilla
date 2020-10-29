//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

class FeatureViewController: UIViewController {

    // MARK: - Subviews

    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 0
        return view
    }()

    private let featureView: UIView

    // MARK: - Lifecycle

    init(feature: Feature) {
        self.featureView = feature.featureView
        super.init(nibName: nil, bundle: nil)
        descriptionLabel.text = feature.description
        title = feature.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.addSubview(descriptionLabel)
        view.addSubview(featureView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        descriptionLabel.configureFrame { maker in
            maker.left(inset: 16).right(inset: 16).top(to: view.nui_safeArea.top, inset: 30).height(50)
        }

        featureView.configureFrame { maker in
            maker.left().right().top(to: descriptionLabel.nui_bottom, inset: 30).bottom()
        }
    }
}
