//
//  ViewController.swift
//  FramezillaExample
//
//  Created by Nikita Ermolenko on 13/05/2017.
//  Copyright © 2017 Nikita Ermolenko. All rights reserved.
//

import UIKit
import Framezilla

class ViewController: UIViewController {

    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .cyan
        return view
    }()

    private lazy var content1: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    private lazy var content2: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    private lazy var content3: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()

    private lazy var content4: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private lazy var label1: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.numberOfLines = 0
        label.text = "Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe"
        return label
    }()

    private lazy var label2: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.numberOfLines = 0
        label.text = "Helloe Helloe Helloe Helloe Helloe"
        return label
    }()
    

    private lazy var label3: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        label.numberOfLines = 0
        label.text = "Helloe"
        return label
    }()

    private lazy var layer1: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        return layer
    }()

    private lazy var layer2: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.green.cgColor
        return layer
    }()

    private lazy var layer3: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.blue.cgColor
        return layer
    }()

    private lazy var mask: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.black.cgColor
        return layer
    }()

    private lazy var textField1: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type Something"
        textField.delegate = self
        textField.backgroundColor = .white
        return textField
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(container)
        view.layer.addSublayer(layer1)
        view.listenForKeyboardEvents()
        layer1.mask = mask
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        [content1, label1, label2, label3, textField1].configure(container: container, relation: .horizontal(left: 20, right: 20)) {
            content1.configureFrame { maker in
                maker.top(inset: 10)
                maker.size(width: 100, height: 60)
                maker.centerX()
            }

            label1.configureFrame { maker in
                maker.left().right().top(to: content1.nui_bottom, inset: 10)
                maker.heightToFit()
            }

            label2.configureFrame { maker in
                maker.left().right().top(to: label1.nui_bottom, inset: 10)
                maker.heightToFit()
            }

            label3.configureFrame { maker in
                maker.left().right().top(to: label2.nui_bottom, inset: 20)
                maker.heightToFit()
            }

            textField1.configureFrame { maker in
                maker.left().right().top(to: label3.nui_bottom, inset: 20)
                maker.heightToFit()
            }
        }

        container.configureFrame { maker in
            maker.centerX()
            if nui_keyboard.isVisible {
                maker.bottom(to: nui_keyboard.top)
            }
            else {
                maker.bottom(to: view.nui_safeArea.bottom, inset: 20)
            }
        }

        [layer2, layer3].configure(container: layer1) {
            layer2.configureFrame { maker in
                maker.size(width: 100, height: 20).centerY()
            }
            layer3.configureFrame { maker in
                maker.size(width: 20, height: 100).centerX()
            }
        }

        layer1.configureFrame { maker in
            maker.top(to: view.nui_safeArea.top, inset: 10).centerX()
        }

        mask.configureFrame { maker in
            maker.equal(to: layer1)
        }

        updateMaskPath()
    }

    // MARK: - Private

    private func updateMaskPath() {
        let path = CGMutablePath()
        let width: CGFloat = mask.bounds.width
        let height: CGFloat = mask.bounds.height
        stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 6).forEach {
            angle in
            let radius = min(width, height) / 2
            var transform  = CGAffineTransform(rotationAngle: angle)
                .concatenating(CGAffineTransform(translationX: width / 2, y: height / 2))

            let petal = CGPath(ellipseIn: CGRect(x: 0.2 * radius, y: 0, width: 0.3 * radius, height: radius),
                               transform: &transform)

            path.addPath(petal)
        }

        mask.path = path
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
