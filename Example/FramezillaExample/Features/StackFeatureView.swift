//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit
import Framezilla

final class StackFeatureView: FeatureView {

    private var isHorizontal: Bool = true

    // MARK: - Subviews

    private lazy var addSubviewButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .purple
        view.setTitle("Add subview to stack", for: .normal)
        view.addTarget(self, action: #selector(addSubviewButtonPressed), for: .touchUpInside)
        return view
    }()

    private lazy var changeAxisButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .purple
        view.setTitle("Change axis", for: .normal)
        view.addTarget(self, action: #selector(changeAxisButtonPressed), for: .touchUpInside)
        return view
    }()

    private lazy var stackView: UIView = .init()

    // MARK: - Lifecycle

    override func performAddSubviews() {
        addSubview(addSubviewButton)
        addSubview(changeAxisButton)
        addSubview(stackView)
        stackView.addSubview(greenView)
        stackView.addSubview(pinkView)
    }

    override func performLayout() {
        addSubviewButton.configureFrame { maker in
            maker.left().top(inset: 10).height(30).width(to: nui_width, multiplier: 0.5)
        }
        changeAxisButton.configureFrame { maker in
            maker.right().top(inset: 10).height(30).width(to: nui_width, multiplier: 0.5)
        }
        stackView.configureFrame { maker in
            maker.top(to: addSubviewButton.nui_bottom).left().right().bottom()
        }

        stackView.subviews.stack(axis: isHorizontal ? .horizontal : .vertical)
    }

    // MARK: - Private

    @objc private func addSubviewButtonPressed() {
        let view = UIView()
        view.backgroundColor = UIColor(red: CGFloat.random(in: 0...1),
                                       green: CGFloat.random(in: 0...1),
                                       blue: CGFloat.random(in: 0...1),
                                       alpha: 1)
        stackView.addSubview(view)
        setNeedsLayout()
        layoutIfNeeded()
    }

    @objc private func changeAxisButtonPressed() {
        isHorizontal.toggle()
        setNeedsLayout()
        layoutIfNeeded()
    }
}
