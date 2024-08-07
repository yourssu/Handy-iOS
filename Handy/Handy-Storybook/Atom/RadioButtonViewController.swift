//
//  RadioButtonViewController.swift
//  Handy-Storybook
//
//  Created by 성현주 on 7/27/24.
//

import Handy

final class RadioButtonViewController: BaseViewController {

    let radioButton: HandyRadioButton = {
        let checkBox = HandyRadioButton()
        checkBox.isSelected = true
        return checkBox
    }()

    let textRadioButton: HandyRadioButton = {
        let checkBox = HandyRadioButton()
        checkBox.text = "RadioButton"
        return checkBox
    }()

    let disabledRadioButton: HandyRadioButton = {
        let checkBox = HandyRadioButton()
        checkBox.isDisabled = true
        checkBox.text = "RadioButton"
        return checkBox
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewHierarchies() {
        [radioButton, textRadioButton, disabledRadioButton].forEach {
            view.addSubview($0)
        }
    }

    override func setViewLayouts() {
        radioButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        textRadioButton.snp.makeConstraints {
            $0.top.equalTo(radioButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        disabledRadioButton.snp.makeConstraints {
            $0.top.equalTo(textRadioButton.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}


