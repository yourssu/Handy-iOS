//
//  CheckBoxViewController.swift
//  Handy-Storybook
//
//  Created by 성현주 on 7/26/24.
//

import Handy

final class CheckBoxViewController: BaseViewController {

    let checkBox: HandyCheckBox = {
        let checkBox = HandyCheckBox()
        return checkBox
    }()

    let textCheckBox: HandyCheckBox = {
        let checkBox = HandyCheckBox()
        checkBox.text = "HandyCheckBox"
        return checkBox
    }()

    let disabledCheckBox: HandyCheckBox = {
        let checkBox = HandyCheckBox()
        checkBox.isDisabled = true
        return checkBox
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewHierarchies() {
        [checkBox, textCheckBox, disabledCheckBox].forEach {
            view.addSubview($0)
        }
    }

    override func setViewLayouts() {
        checkBox.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        textCheckBox.snp.makeConstraints {
            $0.top.equalTo(checkBox.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        disabledCheckBox.snp.makeConstraints {
            $0.top.equalTo(textCheckBox.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

