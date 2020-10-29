//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import Framezilla

final class SizeFeatureView: FeatureView {

    // MARK: - Subviews

    private lazy var exampleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.textColor = .white
        view.backgroundColor = .systemPurple
        view.text = "Size to fit example"
        view.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return view
    }()

    private lazy var textField: UITextField = {
        let view = UITextField()
        view.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        view.delegate = self
        view.borderStyle = .roundedRect
        view.placeholder = "Type text here"
        return view
    }()

    private lazy var labelContainerView: UIView = .init()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        listenForKeyboardEvents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        stopListeningForKeyboardEvents()
    }

    override func performAddSubviews() {
        labelContainerView.addSubview(exampleLabel)
        addSubview(labelContainerView)
        addSubview(textField)
    }

    override func performLayout() {
        textField.configureFrame { maker in
            guard let superview = superview else {
                return
            }

            if nui_keyboard.isVisible {
                maker.bottom(to: nui_keyboard.top, inset: 5)
            }
            else {
                maker.bottom(to: superview.nui_safeArea.bottom, inset: 40)
            }

            maker.left().right().heightToFit()
        }

        labelContainerView.configureFrame { maker in
            let sideInset: CGFloat = 16
            maker.left(inset: sideInset).right(inset: sideInset)
                .top().bottom(to: textField.nui_top)
        }

        exampleLabel.configureFrame { maker in
            maker.top().centerX()
                .sizeThatFits(size: labelContainerView.bounds.size)
        }
    }

    // MARK: - Private

    @objc private func textDidChange() {
        exampleLabel.text = textField.text
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - UITextFieldDelegate

extension SizeFeatureView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}
