//
//  MainViewController.swift
//  Handy
//
//  Created by chongin on 12/31/24.
//

import UIKit

class MainViewController: UITableViewController {

    private let components: [HandyStorybookComponent] = [
        .init(("SnackbarViewController", SnackbarViewController())),
        .init(("LabelViewController", LabelViewController())),
        .init(("FabViewController", FabViewController())),
        .init(("HandyBoxButtonViewController", HandyBoxButtonViewController())),
        .init(("ChipViewController", ChipViewController())),
        .init(("DividerViewController", DividerViewController())),
        .init(("CheckBoxViewController", CheckBoxViewController())),
        .init(("RadioButtonViewController", RadioButtonViewController())),
        .init(("HansySwitchViewController", HansySwitchViewController())),
        .init(("TabsViewController", TabsViewController())),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return components.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let component = components[indexPath.row]
            cell.textLabel?.text = component.title
            return cell
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let component = components[indexPath.row]
            navigationController?.pushViewController(component.viewController, animated: true)
        default:
            fatalError()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Components"
        default:
            fatalError()
        }
    }
}

struct HandyStorybookComponent {
    let title: String
    let viewController: UIViewController

    init(title: String, viewController: UIViewController) {
        self.title = title
        self.viewController = viewController
    }

    init<VC: UIViewController>(_ component: (title: String, viewController: VC)) {
        self.title = component.title
        self.viewController = component.viewController as UIViewController
    }
}
