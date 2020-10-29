//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

class FeatureView: UIView {

    // MARK: - Subviews

    private(set) lazy var purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()

    private(set) lazy var greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()

    private(set) lazy var pinkView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        return view
    }()

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray
        performAddSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        purpleView.configureFrame { maker in
            let side = bounds.width / 1.3
            maker.center().size(width: side, height: side)
        }
        performLayout()
    }

    func performLayout() {
    }

    func performAddSubviews() {
        addSubview(purpleView)
        addSubview(greenView)
        addSubview(pinkView)
    }
}
