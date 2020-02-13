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

    let container = UIView()

    let content1 = UIView()
    let content2 = UIView()
    let content3 = UIView()
    let content4 = UIView()

    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()

    let textField1 = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        container.backgroundColor = .cyan

        content1.backgroundColor = .red
        content2.backgroundColor = .black
        content3.backgroundColor = .green
        content4.backgroundColor = .gray

        label1.backgroundColor = .red
        label2.backgroundColor = .green
        label3.backgroundColor = .gray

        label1.numberOfLines = 0
        label2.numberOfLines = 0
        label3.numberOfLines = 0

        label1.text = "Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe Helloe"
        label2.text = "Helloe Helloe Helloe Helloe Helloe"
        label3.text = "Helloe"

        textField1.placeholder = "Type Something"
        textField1.delegate = self
        textField1.backgroundColor = .white

        view.addSubview(container)
        view.listenForKeyboardEvents()
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
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
