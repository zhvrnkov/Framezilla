//
//  Copyright © 2019 Rosberry. All rights reserved.
//

import UIKit

public class Keyboard: EdgeRelationCollection {

    var rect: CGRect {
        return KeyboardRectCloneView.shared.frame
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
