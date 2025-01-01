//
//  TabsViewController.swift
//  Handy
//
//  Created by chongin on 12/29/24.
//

import Handy
import UIKit

final class TabsViewController: BaseViewController {
    var tabs: [(title: String, viewController: UIViewController)]

    private let handyTabs: HandyTabs = {
        let tabs = HandyTabs(sizeType: .small)
        return tabs
    }()

    private let addingTabButton: HandyFab = {
        let button = HandyFab()
        button.iconImage = .add
        return button
    }()

    init(_ tabCount: Int) {
        self.tabs = [
            {
                let viewController = SnackbarViewController()
                return ("SnackbarViewController", viewController)
            }(),
            {
                let viewController = LabelViewController()
                return ("LabelViewController", viewController)
            }(),
            {
                let viewController = FabViewController()
                return ("FabViewController", viewController)
            }(),
            {
                let viewController = HandyBoxButtonViewController()
                return ("HandyBoxButtonViewController", viewController)
            }(),
            {
                let viewController = ChipViewController()
                return ("ChipViewController", viewController)
            }(),
            {
                let viewController = DividerViewController()
                return ("DividerViewController", viewController)
            }(),
            {
                let viewController = CheckBoxViewController()
                return ("CheckBoxViewController", viewController)
            }(),
            {
                let viewController = RadioButtonViewController()
                return ("RadioButtonViewController", viewController)
            }(),
            {
                let viewController = HansySwitchViewController()
                return ("HansySwitchViewController", viewController)
            }(),
        ][..<tabCount].map { $0 }
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addingTabButton.addTarget(self, action: #selector(addingTabButtonDidTap(_:)), for: .touchUpInside)
        self.handyTabs.tabs = self.tabs
    }

    @objc private func addingTabButtonDidTap(_ sender: UIButton) {
        let randomViewController = UIViewController()
        randomViewController.view.backgroundColor = UIColor.init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        handyTabs.tabs.append(("newTab!!", randomViewController))
    }

    override func setViewHierarchies() {
        self.addChild(handyTabs)
        self.view.addSubview(handyTabs.view)
        self.view.addSubview(addingTabButton)
    }

    override func setViewLayouts() {
        handyTabs.view.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }

        addingTabButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            $0.width.height.equalTo(100)
        }
    }
}
