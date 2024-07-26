//
//  CheckBoxViewController.swift
//  Handy-Storybook
//
//  Created by 성현주 on 7/26/24.
//

import Handy

final class CheckBoxViewController: BaseViewController {

    let checkBox = HandyCheckBox()

    override func viewDidLoad() {
        super.viewDidLoad()

        checkBox.isDisabled = true
        checkBox.text = nil
        checkBox.size = .large
        checkBox.text = "ddd"
    }

    override func setViewHierarchies() {
        self.view.addSubview(checkBox)
    }

    override func setViewLayouts() {
        checkBox.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}


