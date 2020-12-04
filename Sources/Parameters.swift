//
//  Parameters.swift
//  Framezilla
//
//  Created by Nikita Ermolenko on 30/06/2017.
//
//

import Foundation
import UIKit

final class ValueParameter {
    let value: CGFloat

    init(value: CGFloat) {
        self.value = value
    }
}

final class SideParameter {

    let element: ElementType
    let value: CGFloat
    let relationType: RelationType

    init(element: ElementType, value: CGFloat, relationType: RelationType) {
        self.element = element
        self.value = value
        self.relationType = relationType
    }
}
