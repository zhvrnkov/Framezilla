//
//  Copyright © 2020 Rosberry. All rights reserved.
//

final class Feature {

    let title: String
    let description: String
    let featureView: FeatureView

    init(title: String, description: String, featureView: FeatureView) {
        self.title = title
        self.description = description
        self.featureView = featureView
    }
}
