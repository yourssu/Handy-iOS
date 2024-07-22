//
//  BaseViewController.swift
//  Handy-Storybook
//
//  Created by 이조은 on 7/23/24.
//

import UIKit

import Handy
import SnapKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        setViewProperties()
        setViewHierarchies()
        setViewLayouts()
    }

    func setViewProperties() { 
        self.view.backgroundColor = .white
    }

    func setViewHierarchies() { }

    func setViewLayouts() { }

}
