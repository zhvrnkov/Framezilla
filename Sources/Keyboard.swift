//
//  Copyright © 2019 Rosberry. All rights reserved.
//

import UIKit

public class Keyboard: EdgeRelationCollection {

    public var rect: CGRect {
        return KeyboardRectCloneView.shared.frame
    }

    public var isVisible: Bool {
        guard let window = KeyboardRectCloneView.shared.window else {
            return false
        }

        return KeyboardRectCloneView.shared.frame.minY != window.frame.maxY
    }

    init() {
        if KeyboardRectCloneView.shared.window == nil {
            Maker.initializeKeyboardTracking()
        }

        super.init(view: KeyboardRectCloneView.shared)
    }
}

public var nui_keyboard: Keyboard {
    return Keyboard()
}
