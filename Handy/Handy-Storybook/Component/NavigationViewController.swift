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
        viewController.view.backgroundColor = HandySemantic.bgStatusPositive
        viewController.tabBarItem = UITabBarItem(title: "Label", image: HandyIcon.icHomeFilled, selectedImage: HandyIcon.icHomeFilled)
        return viewController
    }()
    
    let page2: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = HandySemantic.bgBasicBlack
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
        viewController.view.backgroundColor = HandySemantic.iconBasicSecondary
        viewController.tabBarItem = UITabBarItem(title: "Label", image: HandyIcon.icHomeFilled, selectedImage: HandyIcon.icHomeFilled)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([page1, page2, page3, page4, page5], animated: false)
    }
}
