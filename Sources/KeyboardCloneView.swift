//
//  Copyright © 2019 Rosberry. All rights reserved.
//

import UIKit

final class KeyboardRectCloneView: UIView {
    static var shared: KeyboardRectCloneView = KeyboardRectCloneView(frame: .zero)

    var subscribers: [WeakRef<UIView>] = []
    var observer: NSKeyValueObservation?

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
        window.addSubview(self)
        frame.origin.y = window.bounds.maxY

        let keyPath: KeyPath<UIWindow, CGRect> = \UIWindow.frame
        observer = window.observe(keyPath, options: [.old, .new]) { [weak self] (_, change: NSKeyValueObservedChange<CGRect>) in
            guard let self = self, let oldRect = change.oldValue, let newRect = change.newValue else {
                return
            }

            if oldRect.maxY == self.frame.minY {
                self.frame.origin.y = newRect.maxY
            }
        }
    }

    @objc private func keyboardFrameChanged(_ notification: NSNotification) {
        guard let rect = notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        frame = rect

        subscribers.compact().forEach { (reference: WeakRef<UIView>) in
            guard reference.object?.window != nil else {
                return
            }

            reference.object?.setNeedsLayout()
            reference.object?.layoutIfNeeded()
        }
    }
}
