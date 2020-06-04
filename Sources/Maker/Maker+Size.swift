//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

extension Maker {

    // MARK: High priority

    func _width(_ width: Number) {
        let handler = { [unowned self] in
            self.newRect.setValue(width.value, for: .width)
        }
        handlers.append((.high, handler))
        widthParameter = ValueParameter(value: width.value)
    }

    func _width(to relationView: RelationView<SizeRelation>, multiplier: Number = 1.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            if view != self.view {
                let width = self.relationSize(view: view, for: relationType) * multiplier.value
                self.newRect.setValue(width, for: .width)
            }
            else {
                if let parameter = self.heightParameter {
                    self.newRect.setValue(parameter.value * multiplier.value, for: .width)
                }
                else if let parameter = self.heightToParameter {
                    let width = self.relationSize(view: parameter.view, for: parameter.relationType) * (parameter.value * multiplier.value)
                    self.newRect.setValue(width, for: .width)
                }
                else {
                    guard let topParameter = self.topParameter, let bottomParameter = self.bottomParameter else {
                        return
                    }

                    let topViewY = self.convertedValue(for: topParameter.relationType, with: topParameter.view) + topParameter.value
                    let bottomViewY = self.convertedValue(for: bottomParameter.relationType, with: bottomParameter.view) - bottomParameter.value

                    self.newRect.setValue((bottomViewY - topViewY) * multiplier.value, for: .width)
                }
            }
        }
        handlers.append((.high, handler))
        widthToParameter = SideParameter(view: view, value: multiplier.value, relationType: relationType)
    }

    func _height(_ height: Number) {
        let handler = { [unowned self] in
            self.newRect.setValue(height.value, for: .height)
        }
        handlers.append((.high, handler))
        heightParameter = ValueParameter(value: height.value)
    }

    func _height(to relationView: RelationView<SizeRelation>, multiplier: Number = 1.0) {
        let view = relationView.view
        let relationType = relationView.relationType

        let handler = { [unowned self] in
            if view != self.view {
                let height = self.relationSize(view: view, for: relationType) * multiplier.value
                self.newRect.setValue(height, for: .height)
            }
            else {
                if let parameter = self.widthParameter {
                    self.newRect.setValue(parameter.value * multiplier.value, for: .height)
                }
                else if let parameter = self.widthToParameter {
                    let height = self.relationSize(view: parameter.view, for: parameter.relationType) * (parameter.value * multiplier.value)
                    self.newRect.setValue(height, for: .height)
                }
                else {
                    guard let leftParameter = self.leftParameter, let rightParameter = self.rightParameter else {
                        return
                    }

                    let leftViewX = self.convertedValue(for: leftParameter.relationType, with: leftParameter.view) + leftParameter.value
                    let rightViewX = self.convertedValue(for: rightParameter.relationType, with: rightParameter.view) - rightParameter.value

                    self.newRect.setValue((rightViewX - leftViewX) * multiplier.value, for: .height)
                }
            }
        }
        handlers.append((.high, handler))
        heightToParameter = SideParameter(view: view, value: multiplier.value, relationType: relationType)
    }

    func _size(width: Number, height: Number) {
        _width(width)
        _height(height)
    }

    func _size(_ size: CGSize) {
        _size(width: size.width, height: size.height)
    }
}
