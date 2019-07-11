//
//  UIView+Keyboard.swift
//  Framezilla iOS
//
//  Created by Anton K on 13/06/2019.
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
