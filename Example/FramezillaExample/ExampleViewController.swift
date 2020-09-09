//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

final class ExampleViewController: UIViewController {

    private let features: [Feature] = [.init(title: "Edges",
                                             description: "maker.edges(insets: .init(top: 10, left: 20, bottom: 30, right: 40))",
                                             featureView: EdgesFeatureView()),
                                       .init(title: "Relations",
                                             description: "Description",
                                             featureView: SideRelationFeatureView()),
                                       .init(title: "SizeToFit and SizeThatFits", description: "Description", featureView: EdgesFeatureView()),
                                       .init(title: "Keyboard", description: "Description", featureView: KeyboardFeatureView()),
                                       .init(title: "Container", description: "Description", featureView: EdgesFeatureView()),
                                       .init(title: "Stack", description: "Description", featureView: EdgesFeatureView())]

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
            fatalError("Can't find ToggleCellTableViewCell")
        }

        cell.textLabel?.text = title
        cell.selectionStyle = .none
        return cell
    }
}
