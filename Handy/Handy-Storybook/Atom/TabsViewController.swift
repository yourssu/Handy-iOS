//
//  TabsViewController.swift
//  Handy
//
//  Created by chongin on 12/29/24.
//

import Handy

final class TabsViewController: BaseViewController {
    private let tabs: HandyTabs = {
        let tabs = HandyTabs(sizeType: .small)
        tabs.tabs = [
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
        ]
        return tabs
    }()

    override func setViewHierarchies() {
        self.addChild(tabs)
        self.view.addSubview(tabs.view)
    }

    override func setViewLayouts() {
        tabs.view.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

