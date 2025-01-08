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
        let uiSearchBar = HandySearchBar()
        return uiSearchBar
    }()
    private let searchBar2: HandySearchBar = {
        let uiSearchBar = HandySearchBar()
        uiSearchBar.rightIcon = false
        return uiSearchBar
    }()
    private let searchBar3: HandySearchBar = {
        let uiSearchBar = HandySearchBar()
        uiSearchBar.leftIcon = false
        return uiSearchBar
    }()
    private let searchBar4: HandySearchBar = {
        let uiSearchBar = HandySearchBar()
        uiSearchBar.leftIcon = false
        uiSearchBar.rightIcon = false
        uiSearchBar.placeholder = "Custom"
        return uiSearchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        setupButtonTargets()
    }

    override func setViewHierarchies() {
        self.view.addSubview(searchBar1)
        self.view.addSubview(searchBar2)
        self.view.addSubview(searchBar3)
        self.view.addSubview(searchBar4)
    }

    override func setViewLayouts() {
        searchBar1.snp.makeConstraints {
            $0.bottom.equalTo(searchBar2.snp.top).offset(-20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchBar2.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchBar3.snp.makeConstraints {
            $0.top.equalTo(searchBar2.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchBar4.snp.makeConstraints {
            $0.top.equalTo(searchBar3.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    private func setupButtonTargets() {
        // searchBar1
        searchBar1.leftButton.addTarget(self, action: #selector(leftButtonTapped(_:)), for: .touchUpInside)
        searchBar1.rightButton.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)

        // searchBar2
        searchBar2.leftButton.addTarget(self, action: #selector(leftButtonTapped(_:)), for: .touchUpInside)

        // searchBar3
        searchBar3.rightButton.addTarget(self, action: #selector(rightButtonTapped(_:)), for: .touchUpInside)
    }

    @objc private func leftButtonTapped(_ sender: UIButton) {
        print("Left button tapped")
    }

    @objc private func rightButtonTapped(_ sender: UIButton) {
        print("Right button tapped")
    }
}

