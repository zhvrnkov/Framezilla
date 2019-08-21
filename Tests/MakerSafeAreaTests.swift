//
//  MakerSafeAreaTests.swift
//  FramezillaTests
//
//  Created by Nikita Ermolenko on 21/10/2017.
//

import XCTest
import Framezilla

class MakerSafeAreaTests: XCTestCase {
    
    private let viewController = UIViewController()
    
    override func setUp() {
        super.setUp()
        viewController.view.frame = CGRect(x: 0, y: 0, width: 300, height: 500)
        
        let window = UIWindow()
        window.rootViewController = viewController
        window.isHidden = false
    }
    
    override func tearDown() {
        if #available(iOS 11.0, *) {
            viewController.additionalSafeAreaInsets = .zero
        }
        super.tearDown()
    }
    
    /* top */
    
    func testThatCorrectlyConfigures_top_to_SafeArea() {
        guard #available(iOS 11.0, *) else {
            return
        }
        
        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.top = 10
        
        view.configureFrame { maker in
            maker.top(to: viewController.view.nui_safeArea.top)
            maker.left()
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: 0, y: viewController.additionalSafeAreaInsets.top, width: 20, height: 20))
    }
    
    func testThatCorrectlyConfigures_top_to_SafeAreaWithInset() {
        guard #available(iOS 11.0, *) else {
            return
        }

        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.top = 10
        
        let inset: CGFloat = 5
        view.configureFrame { maker in
            maker.top(to: viewController.view.nui_safeArea.top, inset: inset)
            maker.left()
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: 0, y: viewController.additionalSafeAreaInsets.top + inset, width: 20, height: 20))
    }
    
    /* left */
    
    func testThatCorrectlyConfigures_left_to_SafeArea() {
        guard #available(iOS 11.0, *) else {
            return
        }
        
        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.left = 10
        
        view.configureFrame { maker in
            maker.top()
            maker.left(to: viewController.view.nui_safeArea.left)
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: viewController.additionalSafeAreaInsets.left, y: 0, width: 20, height: 20))
    }
    
    func testThatCorrectlyConfigures_left_to_SafeAreaWithInset() {
        guard #available(iOS 11.0, *) else {
            return
        }

        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.left = 10
        
        let inset: CGFloat = 5
        view.configureFrame { maker in
            maker.top()
            maker.left(to: viewController.view.nui_safeArea.left, inset: inset)
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: viewController.additionalSafeAreaInsets.left + inset,
                                          y: 0,
                                          width: 20,
                                          height: 20))
    }
    
    /* bottom */
    
    func testThatCorrectlyConfigures_bottom_to_SafeArea() {
        guard #available(iOS 11.0, *) else {
            return
        }

        
        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.bottom = 10
        
        view.configureFrame { maker in
            maker.bottom(to: viewController.view.nui_safeArea.bottom)
            maker.left()
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: 0,
                                          y: viewController.view.frame.height - viewController.additionalSafeAreaInsets.bottom - 20,
                                          width: 20,
                                          height: 20))
    }
    
    func testThatCorrectlyConfigures_bottom_to_SafeAreaWithInset() {
        guard #available(iOS 11.0, *) else {
            return
        }
        
        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.bottom = 10
        
        let inset: CGFloat = 5
        view.configureFrame { maker in
            maker.bottom(to: viewController.view.nui_safeArea.bottom, inset: inset)
            maker.left()
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: 0,
                                          y: viewController.view.frame.height - viewController.additionalSafeAreaInsets.bottom - 20 - inset,
                                          width: 20,
                                          height: 20))
    }
    
    /* right */
    
    func testThatCorrectlyConfigures_right_to_SafeArea() {
        guard #available(iOS 11.0, *) else {
            return
        }

        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.right = 10
        
        view.configureFrame { maker in
            maker.right(to: viewController.view.nui_safeArea.right)
            maker.bottom()
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: viewController.view.frame.width - viewController.additionalSafeAreaInsets.right - 20,
                                          y: viewController.view.frame.height - 20,
                                          width: 20,
                                          height: 20))
    }
    
    func testThatCorrectlyConfigures_right_to_SafeAreaWithInset() {
        guard #available(iOS 11.0, *) else {
            return
        }
        
        let view = UIView()
        viewController.view.addSubview(view)
        viewController.additionalSafeAreaInsets.right = 10
        
        let inset: CGFloat = 5
        view.configureFrame { maker in
            maker.right(to: viewController.view.nui_safeArea.right, inset: inset)
            maker.bottom()
            maker.size(width: 20, height: 20)
        }

        XCTAssertEqual(view.frame, CGRect(x: viewController.view.frame.width - viewController.additionalSafeAreaInsets.right - 20 - inset,
                                          y: viewController.view.frame.height - 20,
                                          width: 20,
                                          height: 20))
    }
}
