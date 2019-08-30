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

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }

    // MARK: -

    func use(_ window: UIWindow) {
        window.addSubview(self)

        frame.origin.y = window.bounds.maxY
        frame.size.width = window.bounds.width

        let keyPath: KeyPath<UIWindow, CGRect> = \UIWindow.frame
        observer = window.observe(keyPath, options: [.old, .new]) { [weak self] (_, change: NSKeyValueObservedChange<CGRect>) in
            guard let self = self, let oldRect = change.oldValue, let newRect = change.newValue else {
                return
            }

            self.frame.size.width = newRect.width
            if oldRect.maxY == self.frame.minY {
                self.frame.origin.y = newRect.maxY
            }
        }
    }

    @objc private func keyboardFrameChanged(_ notification: NSNotification) {
        guard let rect = notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        if rect.isEmpty, let superview = superview {
            frame = superview.bounds
            frame.origin.y = superview.bounds.maxY
        }
        else {
            frame = rect
        }

        subscribers.compact().forEach { (reference: WeakRef<UIView>) in
            guard reference.object?.window != nil else {
                return
            }

            reference.object?.setNeedsLayout()
            reference.object?.layoutIfNeeded()
        }
    }
}
