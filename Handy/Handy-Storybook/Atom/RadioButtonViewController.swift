//
//  RadioButtonViewController.swift
//  Handy-Storybook
//
//  Created by 성현주 on 7/27/24.
//

import Handy

final class RadioButtonViewController: BaseViewController {

    let checkBox: HandyRadioButton = {
        let checkBox = HandyRadioButton()
        return checkBox
    }()

    let textCheckBox: HandyRadioButton = {
        let checkBox = HandyRadioButton()
        checkBox.text = "HandyCheckBox"
        return checkBox
    }()

    let disabledCheckBox: HandyRadioButton = {
        let checkBox = HandyRadioButton()
        checkBox.isDisabled = true
        return checkBox
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewHierarchies() {
        self.view.addSubview(checkBox)
        self.view.addSubview(textCheckBox)
        self.view.addSubview(disabledCheckBox)
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


