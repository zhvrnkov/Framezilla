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
         .init(title: "Container", description: "Description", featureView: EdgesFeatureView()),
         .init(title: "Safe area", description: "Description", featureView: SafeAreaFeatureView())]
    }

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()

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

extension ExampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feature = features[indexPath.row]
        let viewController = FeatureViewController(feature: feature)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return features.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dequeueCell(with: features[indexPath.row].title, for: indexPath)
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
