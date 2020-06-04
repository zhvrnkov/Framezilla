//
//  Copyright © 2019 Rosberry. All rights reserved.
//

import XCTest
import Framezilla

final class DummyView: UIView {
    var layoutHandler: (() -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutHandler?()
    }
}

final class KeyboardTests: BaseTest {

    private func postKeyboardNotification(rect: CGRect) {
        NotificationCenter.default.post(name: UIApplication.keyboardWillChangeFrameNotification,
                                        object: nil,
                                        userInfo: [
            UIApplication.keyboardFrameEndUserInfoKey: rect
        ])
    }

    private func prepareWindow() -> UIWindow {
        let window = UIWindow()
        window.frame = UIScreen.main.bounds
        window.makeKeyAndVisible()
        return window
    }

    private func prepareView() -> DummyView {
        let view = DummyView()
        let window = prepareWindow()

        window.addSubview(view)
        view.frame = window.bounds
        view.layoutIfNeeded()

        return view
    }

    func testKeyboardListen() {
        let view = prepareView()
        let layoutExpectation = expectation(description: "layoutExpectation")

        view.listenForKeyboardEvents()
        view.layoutHandler = {
            layoutExpectation.fulfill()
        }

        postKeyboardNotification(rect: .zero)
        wait(for: [layoutExpectation], timeout: 1.0)
    }

    func testKeyboardStopListening() {
        let view = prepareView()

        view.listenForKeyboardEvents()
        view.stopListeningForKeyboardEvents()

        view.layoutHandler = {
            XCTFail("Layout shouldn't be performed if view is not listening for keyboard events")
        }

        postKeyboardNotification(rect: .zero)
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1))
    }

    func testKeyboardVisibility() {
        let window = prepareWindow()
        Maker.initializeKeyboardTracking(with: window)

        XCTAssert(nui_keyboard.isVisible == false)
        postKeyboardNotification(rect: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        XCTAssert(nui_keyboard.isVisible == true)
        postKeyboardNotification(rect: CGRect(x: 0.0, y: window.bounds.maxY, width: 100.0, height: 100.0))
        XCTAssert(nui_keyboard.isVisible == false)
    }

    func testKeyboardRect() {
        let window = prepareWindow()
        Maker.initializeKeyboardTracking(with: window)

        XCTAssert(nui_keyboard.rect.isEmpty)

        let rect = CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0)
        postKeyboardNotification(rect: rect)
        XCTAssert(nui_keyboard.rect == rect)
    }

    func testKeyboardRelations() {
        let window = prepareWindow()
        Maker.initializeKeyboardTracking(with: window)

        let view = prepareView()
        let layoutExpectation = expectation(description: "layoutExpectation")
        let rect = CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0)

        view.listenForKeyboardEvents()
        view.layoutHandler = {
            view.configureFrame(installerBlock: { maker in
                maker.left(to: nui_keyboard.left)
                maker.right(to: nui_keyboard.right)
                maker.top(to: nui_keyboard.top)
                maker.bottom(to: nui_keyboard.bottom)
            })
            XCTAssert(view.frame == rect)
            layoutExpectation.fulfill()
        }

        postKeyboardNotification(rect: rect)
        wait(for: [layoutExpectation], timeout: 1.0)
    }
}
