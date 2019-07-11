//
//  KeyboardRectCloneView.swift
//  Framezilla iOS
//
//  Created by Anton K on 13/06/2019.
//

import UIKit

final class KeyboardRectCloneView: UIView {
    static var shared: KeyboardRectCloneView = KeyboardRectCloneView(frame: .zero)

    var subscribers: [WeakRef<UIView>] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardFrameChanged(_:)),
                                               name: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func use(_ window: UIWindow) {
        if superview != nil {
            removeObserver(self, forKeyPath: "window.frame")
        }

        window.addSubview(self)
        frame.origin.y = window.bounds.maxY
        addObserver(self, forKeyPath: "window.frame", options:[.old, .new], context: nil)
    }

    @objc private func keyboardFrameChanged(_ notification: NSNotification) {
        guard let rect = notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        frame = rect

        subscribers.compact().forEach { (reference: WeakRef<UIView>) in
            reference.object?.setNeedsLayout()
            reference.object?.layoutIfNeeded()
        }
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        guard let oldRect = change?[.oldKey] as? CGRect,
              let newRect = change?[.newKey] as? CGRect else {
            return
        }

        if oldRect.maxY == frame.minY {
            frame.origin.y = newRect.maxY
        }
    }
}
