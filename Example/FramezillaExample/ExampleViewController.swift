//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class ExampleViewController: UIViewController {

    private var features: [Feature] {
        [.init(title: "Edges",
               description: "Green view is subview of purple view and related by function\nedges(insets: .init(top: 10, left: 20, bottom: 30, right: 40))",
               featureView: EdgesFeatureView()),
         .init(title: "Relations",
               description: "Left side of green view related to left side of purple and right side related to midX relation of purple view. For red view its same but mirrored",
               featureView: SideRelationFeatureView()),
         .init(title: "Keyboard",
               description: "Bottom side of text field related to top of keyboard and green and red views bottom side related to top of text field by 16",
               featureView: KeyboardFeatureView()),
         .init(title: "Stack", description: "You can use stack function to layout views one after another in superview horizontally or vertically", featureView: StackFeatureView()),
         .init(title: "Center on arc", description: "Center of green view pinned to arc of circle", featureView: ArcCenterFeature()),
         .init(title: "Safe area", description: "Purple view pinned to bottom safe area", featureView: SafeAreaFeatureView()),
         .init(title: "Min/Max relations",
               description: "Purple view pined to right relation of view with minimum X value",
               featureView: MinMaxFeatureView()),
         .init(title: "SizeThatFits/ sizeToFit",
               description: "Size of label calculates of text change on fits in area from top to top of textField",
               featureView: SizeFeatureView())]
    }

    // MARK: - Subviews

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Framezilla example"
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
        tableView.contentInset = .init(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
}

// MARK: - UITableViewDelegate

extension ExampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = features[indexPath.row]
        let viewController = FeatureViewController(feature: feature)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        features.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dequeueCell(with: features[indexPath.row].title, for: indexPath)
    }

    private func dequeueCell(with title: String, for indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description()) else {
            fatalError("Can't find cell")
        }

        cell.textLabel?.text = title
        cell.selectionStyle = .none
        return cell
    }
}
