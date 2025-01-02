//
//  TextFieldViewController.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit
import SnapKit

import Handy

final class TextFieldViewController: BaseViewController {

    private let defaultField: HandyTextFieldView = {
        let textField = HandyTextFieldView()
        textField.placeholder = "Input text"
        textField.fieldLabelText = "Label"
        textField.helperLabelText = "Helper text"
        return textField
    }()
    
    private let filledField: HandyTextFieldView = {
        let textField = HandyTextFieldView()
        textField.text = "Text Inputting"
        textField.placeholder = "Input text"
        textField.fieldLabelText = "Label"
        textField.helperLabelText = "Helper text"
        return textField
    }()
    
    private let errorField: HandyTextFieldView = {
        let textField = HandyTextFieldView()
        textField.placeholder = "Input text"
        textField.fieldLabelText = "Label"
        textField.helperLabelText = "Helper text"
        textField.isNegative = true
        return textField
    }()

    private let disabledField: HandyTextFieldView = {
        let textField = HandyTextFieldView()
        textField.placeholder = "Input text"
        textField.fieldLabelText = "Label"
        textField.helperLabelText = "Helper text"
        textField.isDisabled = true
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayouts()
    }
    
    override func setViewHierarchies() {
        [
            defaultField,
            filledField,
            errorField,
            disabledField
        ].forEach {
            view.addSubview($0)
        }
    }

    override func setViewLayouts() {
        defaultField.snp.makeConstraints {
            $0.bottom.equalTo(filledField.snp.top).offset(-16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        filledField.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-50)
            $0.top.equalTo(defaultField.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        errorField.snp.makeConstraints {
            $0.top.equalTo(filledField.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        disabledField.snp.makeConstraints {
            $0.top.equalTo(errorField.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
