//
//  MakerTests.swift
//  Framezilla
//
//  Created by Nikita on 06/09/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

import XCTest
import Framezilla

class MakerTests: BaseTest {
    
    /* Array configurator */
    
    func testThatCorrectlyConfiguresFramesForArrayOfViews() {

        let label = UILabel(frame: .zero)
        testingView.addSubview(label)

        let view = UIView(frame: .zero)
        testingView.addSubview(view)
        
        [label, view].configureFrames { maker in
            maker.width(100)
            maker.height(50)
        }
        XCTAssertEqual(label.frame, CGRect(x: 0, y: 0, width: 100, height: 50))
        XCTAssertEqual(view.frame, CGRect(x: 0, y: 0, width: 100, height: 50))
    }
    
    /* bottom_to with nui_top */
    
    func testThatCorrectlyConfigures_bottom_to_withAnotherView_top_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom(to: nestedView2.nui_top)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 100, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_bottom_to_withAnotherView_top_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom(to: nestedView2.nui_top, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 90, width: 50, height: 50))
    }
    
    /* bottom_to with nui_centerY */
    
    func testThatCorrectlyConfigures_bottom_to_withAnotherView_centerY_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom(to: nestedView2.nui_centerY)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 200, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_bottom_to_withAnotherView_centerY_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom(to: nestedView2.nui_centerY, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 190, width: 50, height: 50))
    }
    
    /* bottom_to with nui_bottom */
    
    func testThatCorrectlyConfigures_bottom_to_withAnotherView_bottom_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom(to: nestedView2.nui_bottom)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 300, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_bottom_to_withAnotherView_bottom_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom(to: nestedView2.nui_bottom, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 290, width: 50, height: 50))
    }
    
    
    
    /* top_to with nui_top */
    
    func testThatCorrectlyConfigures_top_to_withAnotherView_top_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.top(to: nestedView2.nui_top)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 150, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_top_to_withAnotherView_top_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.top(to: nestedView2.nui_top, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 160, width: 50, height: 50))
    }
    
    /* top_to with nui_centerY */
    
    func testThatCorrectlyConfigures_top_to_withAnotherView_centerY_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.top(to: nestedView2.nui_centerY)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 250, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_top_to_withAnotherView_centerY_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.top(to: nestedView2.nui_centerY, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 260, width: 50, height: 50))
    }
    
    /* top_to with nui_bottom */
    
    func testThatCorrectlyConfigures_top_to_withAnotherView_bottom_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.top(to: nestedView2.nui_bottom)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 350, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_top_to_withAnotherView_bottom_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.top(to: nestedView2.nui_bottom, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 360, width: 50, height: 50))
    }
    
    
    
    /* right_to with nui_right */
    
    func testThatCorrectlyConfigures_right_to_withAnotherView_right_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.right(to: nestedView2.nui_right)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 300, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_right_to_withAnotherView_right_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.right(to: nestedView2.nui_right, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 290, y: 0, width: 50, height: 50))
    }
    
    /* top_to with nui_centerX */
    
    func testThatCorrectlyConfigures_right_to_withAnotherView_centerX_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.right(to: nestedView2.nui_centerX)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 200, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_right_to_withAnotherView_centerX_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.right(to: nestedView2.nui_centerX, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 190, y: 0, width: 50, height: 50))
    }
    
    /* top_to with nui_left */
    
    func testThatCorrectlyConfigures_right_to_withAnotherView_left_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.right(to: nestedView2.nui_left)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 100, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_right_to_withAnotherView_left_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.right(to: nestedView2.nui_left, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 90, y: 0, width: 50, height: 50))
    }
    
    
    
    /* left_to with nui_right */
    
    func testThatCorrectlyConfigures_left_to_withAnotherView_right_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.left(to: nestedView2.nui_right)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 350, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_left_to_withAnotherView_right_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.left(to: nestedView2.nui_right, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 360, y: 0, width: 50, height: 50))
    }
    
    /* left_to with nui_centerX */
    
    func testThatCorrectlyConfigures_left_to_withAnotherView_centerX_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.left(to: nestedView2.nui_centerX)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 250, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_left_to_withAnotherView_centerX_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.left(to: nestedView2.nui_centerX, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 260, y: 0, width: 50, height: 50))
    }
    
    /* left_to with nui_left */
    
    func testThatCorrectlyConfigures_left_to_withAnotherView_left_relationWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.left(to: nestedView2.nui_left)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 150, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_left_to_withAnotherView_left_relationWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.left(to: nestedView2.nui_left, inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 160, y: 0, width: 50, height: 50))
    }
    
    
    
    /* left to superview */
    
    func testThatCorrectlyConfigures_left_toSuperviewWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.left()
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_left_toSuperviewWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.left(inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 10, y: 0, width: 50, height: 50))
    }
    
    /* top to superview */
    
    func testThatCorrectlyConfigures_top_toSuperviewWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.top()
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_top_toSuperviewWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.top(inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 10, width: 50, height: 50))
    }
    
    
    /* bottom to superview */
    
    func testThatCorrectlyConfigures_bottom_toSuperviewWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom()
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 450, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_bottom_toSuperviewWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.bottom(inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 0, y: 440, width: 50, height: 50))
    }
    
    
    /* right to superview */
    
    func testThatCorrectlyConfigures_right_toSuperviewWith_zeroInset() {
        
        testingView.configureFrame { maker in
            maker.right()
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 450, y: 0, width: 50, height: 50))
    }
    
    func testThatCorrectlyConfigures_right_toSuperviewWith_nonZeroInset() {
        
        testingView.configureFrame { maker in
            maker.right(inset: 10)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 440, y: 0, width: 50, height: 50))
    }
    
    
    /* edges */
    
    func testThatCorrectlyConfigures_margin_relation() {
        
        let inset: CGFloat = 5
        testingView.configureFrame { maker in
            maker.margin(inset)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: inset, y: inset, width: 490, height: 490))
    }
    
    func testThatCorrectlyConfigures_equal_to_relationForNearSubview() {
        
        let insets = UIEdgeInsets(top: 5, left: 10, bottom: 15, right: 20)
        testingView.configureFrame { maker in
            maker.equal(to: nestedView1, insets: insets)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: nestedView1.frame.minX + insets.left,
                                                 y: nestedView1.frame.minY + insets.top,
                                                 width: nestedView1.bounds.width-(insets.left + insets.right),
                                                 height: nestedView1.bounds.height-(insets.top + insets.bottom)))
    }
    
    func testThatCorrectlyConfigures_equal_to_dependsOnSuperview() {
        testingView.configureFrame { maker in
            maker.equal(to: mainView)
        }
        XCTAssertEqual(testingView.frame, mainView.frame)
    }
    
    func testThatCorrectlyConfigures_edge_insets_toSuperview() {
        
        testingView.configureFrame { maker in
            maker.edges(insets: UIEdgeInsets(top: 10, left: 20, bottom: 40, right: 60))
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 20, y: 10, width: 420, height: 450))
    }

    func testThatCorrectlyConfiguresSliceOf_edge_insets_toSuperview() {
        // There're unordered array of available side option sets which will tested.
        let sidesOptions: [Sides] = [.all, .horizontal, .vertical, .left, .right, .bottom, .top].shuffled()
        // All options which will test will saved in this property, for check which option was already done.
        var currentSideOptionSet: Sides = []
        // Default frame properties which will modified like it should be and will compare with current frame late.
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width: CGFloat = testingView.frame.width
        var height: CGFloat = testingView.frame.height
        
        sidesOptions.forEach { sides in
            // Run loop for each option included in option. For example option `horizontal` include `left` and `right`.
            sides.forEach { side in
                // Save current option which will be tested.
                currentSideOptionSet.insert(side)
                // Configure frame with some insets.
                let insets: UIEdgeInsets = .init(top: 20, left: 10, bottom: 15, right: 10)
                testingView.configureFrame { maker in
                    maker.edges(insets: insets, sides: currentSideOptionSet)
                }
                // Update default frame properties like it should be configured in best scenario
                switch side {
                case .bottom:
                    // If configure bottom with already configured top inset, so Y position of view should be equal to
                    // top inset over the superview and height should be calculated too
                    if currentSideOptionSet.contains(.top) {
                        y = insets.top
                        height = mainView.frame.height - insets.top - insets.bottom
                    }
                    // Y position wihout configured top inset before should be equal to distance between main view maxY
                    // and testing view subject to bottom inset
                    else {
                        y = mainView.frame.height - insets.bottom - testingView.frame.height
                    }
                case .left:
                    x = insets.left
                    // If configure left with already configured right inset, so X position shouldn't be changed
                    // but width should be calculated constrained by left and right insets main view width
                    if currentSideOptionSet.contains(.right) {
                        width = mainView.frame.width - insets.left - insets.right
                    }
                case .top:
                    y = insets.top
                    // If configure top with already configured bottom inset, so Y position shouldn't be changed
                    // but height should be calculated constrained by top and bottom insets main view height
                    if currentSideOptionSet.contains(.bottom) {
                        height = mainView.frame.height - insets.top - insets.bottom
                    }
                case .right:
                    // If configure right with already configured left inset, so X position of view should be equal to
                    // left inset over the superview and width should be calculated too
                    if currentSideOptionSet.contains(.left) {
                        x = insets.left
                        width = mainView.frame.width - insets.left - insets.right
                    }
                    // X position wihout configured left inset before should be equal to distance between main view maxX
                    // and testing view subject to right inset
                    else {
                        x = mainView.frame.width - insets.right - testingView.frame.width
                    }
                default:
                    XCTAssertNil(nil, "Side option not exist or not handled")
                }
                // Compare configured view frame with absolute frame
                XCTAssertEqual(testingView.frame,
                               CGRect(x: x, y: y, width: width, height: height),
                               "Actual view frame not equal to absolute frame")
            }
        }

    }

    func testThatCorrectlyConfigures_edge_toSuperview() {
        
        testingView.configureFrame { maker in
            maker.edges(top: 20, left: 20, bottom: 20, right: 20)
        }
        XCTAssertEqual(testingView.frame, CGRect(x: 20, y: 20, width: 460, height: 460))
    }
    
    /* container */
    
    func testThatCorrectlyConfiguresContainer() {
        
        let view1 = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        let view2 = UIView(frame: CGRect(x: 70, y: 70, width: 50, height: 50))

        let container = UIView()
        container.addSubview(view1)
        container.addSubview(view2)
        testingView.addSubview(container)
        
        container.configureFrame { maker in
            maker.container()
        }
        XCTAssertEqual(container.frame, CGRect(x: 0, y: 0, width: 120, height: 120))
    }

    /* size */

    func testSizeConfiguration() {
        let size = CGSize(width: 20, height: 20)
        testingView.frame = .zero
        testingView.configureFrame { maker in
            maker.size(width: size.width, height: size.height)
        }
        XCTAssertEqual(size, testingView.frame.size)
    }

    func testSizeConfigurationWithCGSize() {
        let size = CGSize(width: 50, height: 50)
        testingView.frame = .zero
        testingView.configureFrame { maker in
            maker.size(size)
        }
        XCTAssertEqual(size, testingView.frame.size)
    }
    
    /* sizeToFit */
    
    func testThat_sizeToFit_correctlyConfigures() {

        let label = UILabel()
        label.text = "Hello"
        testingView.addSubview(label)
        
        label.configureFrame { maker in
            maker.sizeToFit()
        }
        XCTAssertGreaterThan(label.bounds.width, 0)
        XCTAssertGreaterThan(label.bounds.height, 0)
    }
    
    /* sizeThatFits */
    
    func testThat_sizeThatFits_correctlyConfigures() {
        
        let label = UILabel()
        label.text = "HelloHelloHelloHello"
        testingView.addSubview(label)
        
        label.configureFrame { maker in
            maker.sizeThatFits(size: CGSize(width: 30, height: 0))
        }
        XCTAssertEqual(label.bounds.width, 30)
        XCTAssertEqual(label.bounds.height, 0)
    }

    /* corner radius */

    func testThat_cornerRadius_correctlyConfigures() {
        testingView.configureFrame { maker in
            maker.cornerRadius(100)
        }
        XCTAssertEqual(testingView.layer.cornerRadius, 100)
    }

    func testThat_cornerRadiusWithHalfWidth_correctlyConfigures() {
        testingView.configureFrame { maker in
            maker.width(100)
            maker.cornerRadius(byHalf: .width)
        }
        XCTAssertEqual(testingView.layer.cornerRadius, 50)
    }

    func testThat_cornerRadiusWithHalfHeight_correctlyConfigures() {
        testingView.configureFrame { maker in
            maker.height(100)
            maker.cornerRadius(byHalf: .height)
        }
        XCTAssertEqual(testingView.layer.cornerRadius, 50)
    }
}
