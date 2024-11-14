//
//  NavigationViewController.swift
//  Handy-Storybook
//
//  Created by 서준영 on 11/13/24.
//

import UIKit
import Handy
import SnapKit

class NavigationViewController: HandyNavigation {
    let page1: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = HandySemantic.bgBasicStrong
        viewController.tabBarItem = UITabBarItem(title: "Label", image: HandyIcon.icHomeFilled, selectedImage: HandyIcon.icHomeFilled)
        return viewController
    }()
    
    let page2: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = HandySemantic.bgStatusPositive
        viewController.tabBarItem = UITabBarItem(title: "Label", image: HandyIcon.icHomeFilled, selectedImage: HandyIcon.icHomeFilled)
        return viewController
    }()
    
    let page3: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = HandySemantic.bgStatusNegative
        viewController.tabBarItem = UITabBarItem(title: "Label", image: HandyIcon.icHomeFilled, selectedImage: HandyIcon.icHomeFilled)
        return viewController
    }()
    
    let page4: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = HandySemantic.bgBasicDefault
        viewController.tabBarItem = UITabBarItem(title: "Label", image: HandyIcon.icHomeFilled, selectedImage: HandyIcon.icHomeFilled)
        return viewController
    }()
    
    let page5: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = HandySemantic.bgBasicLight
        viewController.tabBarItem = UITabBarItem(title: "Label", image: HandyIcon.icHomeFilled, selectedImage: HandyIcon.icHomeFilled)
        return viewController
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.setViewControllers([page1, page2, page3, page4, page5], animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
