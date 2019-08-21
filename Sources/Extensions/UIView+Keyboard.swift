//
//  Copyright © 2019 Rosberry. All rights reserved.
//

import Foundation

public extension UIView {

    func listenForKeyboardEvents() {
        KeyboardRectCloneView.shared.subscribers.append(weak: self)
    }

    var isKeyboardVisible: Bool {
        guard let window = KeyboardRectCloneView.shared.window else {
            return false
        }

        return KeyboardRectCloneView.shared.frame.minY != window.frame.maxY
    }
}
