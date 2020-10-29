//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit
import Framezilla

final class KeyboardFeatureView: FeatureView {

    // MARK: - Subviews

    private lazy var textField: UITextField = {
        let view = UITextField()
        view.delegate = self
        view.borderStyle = .roundedRect
        return view
    }()

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
        super.performAddSubviews()
        addSubview(textField)
    }

    override func performLayout() {
        textField.configureFrame { maker in
            if nui_keyboard.isVisible {
                maker.bottom(to: nui_keyboard.top)
            }
            else {
                maker.top(to: purpleView.nui_bottom)
            }
            maker.size(width: bounds.width - 30, height: 50).centerX()
        }

        greenView.configureFrame { maker in
            maker.left(to: textField.nui_left, inset: 16)
                .bottom(to: textField.nui_top, inset: 16)
                .top(to: purpleView.nui_top, inset: 16)
                .right(to: textField.nui_centerX)
        }

        pinkView.configureFrame { maker in
            maker.left(to: textField.nui_centerX)
                .bottom(to: textField.nui_top, inset: 16)
                .top(to: purpleView.nui_top, inset: 16)
                .right(to: textField.nui_right, inset: 16)
        }
    }
}

// MARK: - UITextFieldDelegate

extension KeyboardFeatureView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
    }
}
