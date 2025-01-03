//
//  HandySearchBarViewController.swift
//  Handy-Storybook
//
//  Created by 성현주 on 1/1/25.
//

import Handy
import UIKit

final class HandySearchBarViewController: BaseViewController {

    private let searchBar1: HandySearchBar = {
        let uiSwitch = HandySearchBar()
        return uiSwitch
    }()
    private let searchBar2: HandySearchBar = {
        let uiSwitch = HandySearchBar()
        uiSwitch.rightIcon = false
        return uiSwitch
    }()
    private let searchBar3: HandySearchBar = {
        let uiSwitch = HandySearchBar()
        uiSwitch.leftIcon = false
        uiSwitch.rightIcon = false
        uiSwitch.placeholder = "custom"
        return uiSwitch
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

    override func setViewHierarchies() {
        self.view.addSubview(searchBar1)
        self.view.addSubview(searchBar2)
        self.view.addSubview(searchBar3)
    }

    override func setViewLayouts() {
        searchBar1.snp.makeConstraints {
            $0.bottom.equalTo(searchBar2.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchBar2.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchBar3.snp.makeConstraints {
            $0.top.equalTo(searchBar2.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

