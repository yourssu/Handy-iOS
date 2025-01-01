//
//  TabsViewController.swift
//  Handy
//
//  Created by chongin on 12/29/24.
//

import Handy
import UIKit

final class TabsViewController: BaseViewController {
    let tabs: [(title: String, viewController: UIViewController)]
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
        self.handyTabs.tabs = self.tabs
    }

    private let handyTabs: HandyTabs = {
        let tabs = HandyTabs(sizeType: .small)
        return tabs
    }()

    override func setViewHierarchies() {
        self.addChild(handyTabs)
        self.view.addSubview(handyTabs.view)
    }

    override func setViewLayouts() {
        handyTabs.view.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

