//
//  Copyright © 2019 Rosberry. All rights reserved.
//

import UIKit

@available(iOS 11.0, *)
public final class SafeAreaRelationCollection: EdgeRelationCollection {

    override init(view: UIView) {
        super.init(view: view)
        
        top = .init(view: view, relation: .safeArea(.top))
        left = .init(view: view, relation: .safeArea(.left))
        right = .init(view: view, relation: .safeArea(.right))
        bottom = .init(view: view, relation: .safeArea(.bottom))
    }
}

public struct SafeArea {}
@available(*, deprecated, message: "Use `view.safeArea.<type>` instead")
public var nui_safeArea: SafeArea {
    return SafeArea()
}
