//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

public extension CALayer {

    /// Apply new configuration state without frame updating.
    ///
    /// - note: Use `DEFAULT_STATE` for setting the state to the default value.

    var nx_state: AnyHashable {
        get {
            if let value = objc_getAssociatedObject(self, &nxStateTypeAssociationKey) as? AnyHashable {
                return value
            }
            else {
                return DEFAULT_STATE
            }
        }
        set {
            objc_setAssociatedObject(self, &nxStateTypeAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension CALayer {

    /// Configures frame of current layer for special state.
    ///
    /// - note: When you configure frame without implicit state parameter (default value), frame configures for the `DEFAULT_STATE`.
    ///
    /// - parameter state:          The state for which you configure frame. Default value: `DEFAULT_STATE`.
    /// - parameter installerBlock: The installer block within which you can configure frame relations.

    func configureFrame(state: AnyHashable = DEFAULT_STATE, installerBlock: InstallerBlock) {
        configureFrame(states: [state], installerBlock: installerBlock)
    }

    /// Configures frame of current layer for special states.
    ///
    /// - note: Don't forget about `DEFAULT_VALUE`.
    ///
    /// - parameter states:         The states for which you configure frame.
    /// - parameter installerBlock: The installer block within which you can configure frame relations.

    func configureFrame(states: [AnyHashable], installerBlock: InstallerBlock) {
        guard superlayer != nil else {
            return
        }

        for state in states {
            Maker.configure(layer: self, for: state, installerBlock: installerBlock)
        }
    }
}

public extension Sequence where Iterator.Element: CALayer {

    /// Configures frames of the layers for special state.
    ///
    /// - note: When you configure frame without implicit state parameter (default value), frame configures for the `DEFAULT_STATE`.
    ///
    /// - parameter state:          The state for which you configure frame. Default value: `DEFAULT_STATE`.
    /// - parameter installerBlock: The installer block within which you can configure frame relations.

    func configureFrames(state: AnyHashable = DEFAULT_STATE, installerBlock: InstallerBlock) {
        for layer in self {
            layer.configureFrame(state: state, installerBlock: installerBlock)
        }
    }

    /// Configures frames of the layers for special states.
    ///
    /// - note: Don't forget about `DEFAULT_VALUE`.
    ///
    /// - parameter states:         The states for which you configure frames.
    /// - parameter installerBlock: The installer block within which you can configure frame relations.

    func configureFrames(states: [AnyHashable], installerBlock: InstallerBlock) {
        for layer in self {
            layer.configureFrame(states: states, installerBlock: installerBlock)
        }
    }
}

public extension Collection where Iterator.Element: CALayer {

    /// Configures all sublayers within a passed container.
    ///
    /// Use this method when you want to calculate width and height by wrapping all sublayers. Or use static parameters.
    ///
    /// - note: It automatically adds all sublayers to the container. Don't add sublayers manually.
    /// - note: If you don't use a static width for instance, important to understand, that it's not correct to call 'left' and 'right' relations together by sublayers,
    ///         because `container` sets width relatively width of sublayers and here is some ambiguous.
    ///
    /// - parameter container:                The layer where a container will be added.
    /// - parameter relation:            The relation of `ContainerRelation` type.
    ///     - `width`:                   The width of a container. If you specify a width only a dynamic height will be calculated.
    ///     - `height`:                  The height of a container. If you specify a height only a dynamic width will be calculated.
    ///     - `horizontal(left, right)`: The left and right insets of a container. If you specify these parameters only a dynamic height will be calculated.
    ///     - `vertical(top, bottom)`:   The top and bottom insets of a container. If you specify these parameters only a dynamic width will be calculated.
    /// - parameter installerBlock:      The installer block within which you should configure frames for all sublayers.

    func configure(container: CALayer, relation: ContainerRelation? = nil, installerBlock: () -> Void) {
        container.frame = .zero

        var relationWidth: CGFloat?
        var relationHeight: CGFloat?

        if let relation = relation {
            switch relation {
            case let .width(width):
                container.frame.size.width = width.value
                relationWidth = width.value

            case let .height(height):
                container.frame.size.height = height.value
                relationHeight = height.value

            case let .horizontal(lInset, rInset):
                container.configureFrame { maker in
                    maker.left(inset: lInset).right(inset: rInset)
                }
                let width = container.frame.width
                container.frame = .zero
                container.frame.size.width = width
                relationWidth = width

            case let .vertical(tInset, bInset):
                container.configureFrame { maker in
                    maker.top(inset: tInset).bottom(inset: bInset)
                }
                let height = container.frame.height
                container.frame = .zero
                container.frame.size.height = height
                relationHeight = height
            }
        }

        for sublayer in self where sublayer.superlayer != container {
            container.addSublayer(sublayer)
        }

        installerBlock()
        container.configureFrame { maker in
            maker._container()
        }

        if let width = relationWidth {
            container.frame.size.width = width
        }

        if let height = relationHeight {
            container.frame.size.height = height
        }

        installerBlock()
    }

    /// Creates a сontainer layer and configures all sublayer within this container.
    ///
    /// Use this method when you want to calculate `width` and `height` by wrapping all sublayers. Or use static parameters.
    ///
    /// - note: It automatically adds all sublayers to the container. Don't add sublayer manually. A generated container is automatically added to a `layer` as well.
    /// - note: If you don't use a static width for instance, important to understand, that it's not correct to call 'left' and 'right' relations together by sublayers,
    ///         because `container` sets width relatively width of sublayers and here is some ambiguous.
    ///
    /// - parameter layer:                The layer where a container will be added.
    /// - parameter relation:            The relation of `ContainerRelation` type.
    ///     - `width`:                   The width of a container. If you specify a width only a dynamic height will be calculated.
    ///     - `height`:                  The height of a container. If you specify a height only a dynamic width will be calculated.
    ///     - `horizontal(left, right)`: The left and right insets of a container. If you specify these parameters only a dynamic height will be calculated.
    ///     - `vertical(top, bottom)`:   The top and bottom insets of a container. If you specify these parameters only a dynamic width will be calculated.
    /// - parameter installerBlock:      The installer block within which you should configure frames for all sublayers.
    ///
    /// - returns: Container layer.

    func container(in layer: CALayer, relation: ContainerRelation? = nil, installerBlock: () -> Void) -> CALayer {
        let container: CALayer
        if let superLayer = first?.superlayer {
            container = superLayer
        }
        else {
            container = CALayer()
        }

        layer.addSublayer(container)
        configure(container: container, relation: relation, installerBlock: installerBlock)
        return container
    }
}
