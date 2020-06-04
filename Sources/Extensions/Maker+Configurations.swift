//
//  Maker+Configurations.swift
//  Framezilla
//
//  Created by Nikita on 27/08/16.
//  Copyright © 2016 Nikita. All rights reserved.
//

import Foundation

postfix operator <<
postfix operator >>

/// Start frame configuration for `DEFAULT_STATE` state.
///
/// - note: Don't forget to call `>>` operator for ending of configuration.
///
/// - parameter view: The view you are configuring.
///
/// - returns: `Maker` instance for chaining relations.

public postfix func << (view: UIView) -> Maker {
    let maker = Maker(view: .view(view))
    maker.newRect = view.frame
    return maker
}

/// Start frame configuration for `DEFAULT_STATE` state.
///
/// - note: Don't forget to call `>>` operator for ending of configuration.
///
/// - parameter layer: The layer you are configuring.
///
/// - returns: `Maker` instance for chaining relations.

public postfix func << (layer: CALayer) -> Maker {
    let maker = Maker(view: .layer(layer))
    maker.newRect = layer.frame
    return maker
}

/// End frame configuration.

public postfix func >> (maker: Maker) {
    if (maker.view.layout.nx_state as? String) == DEFAULT_STATE {
        maker.configureFrame()
    }
}

public typealias UIViewInstallerBlock = (UIViewMaker) -> Void
public typealias CALayerInstallerBlock = (CALayerMaker) -> Void

extension Maker {

    class func configure(view: UIView, for state: AnyHashable, installerBlock: UIViewInstallerBlock) {
        if view.nx_state == state {
            let maker = UIViewMaker(view: .view(view))

            maker.newRect = view.frame
            installerBlock(maker)

            maker.configureFrame()
        }
    }

    class func configure(layer: CALayer, for state: AnyHashable, installerBlock: CALayerInstallerBlock) {
        if layer.nx_state == state {
            let maker = CALayerMaker(view: .layer(layer))

            maker.newRect = layer.frame
            installerBlock(maker)

            maker.configureFrame()
        }
    }

    fileprivate func configureFrame() {
        handlers.sorted {
            $0.priority.rawValue <= $1.priority.rawValue
        }.forEach {
            $0.handler()
        }

        view.layout.frame = newRect
    }
}
