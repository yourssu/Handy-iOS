//
//  TextViewController.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit
import SnapKit

import Handy

final class TextViewController: BaseViewController {
    private let defaultTextView: HandyTextView = {
        let textView = HandyTextView()
        textView.placeholder = "Input text"
        textView.helperLabelText = "알파벳과 숫자만 허용합니다."
        textView.placeholderColor = .lightGray
        
        return textView
    }()
    
    private let noHelperLabelTextView: HandyTextView = {
        let textView = HandyTextView()
        textView.placeholder = "Input text"
        textView.placeholderColor = .lightGray
        
        return textView
    }()

    private let errorTextView: HandyTextView = {
        let textView = HandyTextView()
        textView.placeholder = "Input text"
        textView.helperLabelText = "Helper text"
        textView.placeholderColor = .lightGray
        textView.isNegative = true
        
        return textView
    }()
    
    private let disabledTextView: HandyTextView = {
        let textView = HandyTextView()
        textView.placeholder = "Input text"
        textView.helperLabelText = "Helper text"
        textView.placeholderColor = .lightGray
        textView.isDisabled = true
        
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayouts()
    }
    
    override func setViewProperties() {
        self.view.backgroundColor = .white
        defaultTextView.editingDelegate = self
        defaultTextView.validationDelegate = self
        defaultTextView.textChangeDelegate = self
    }
    
    override func setViewHierarchies() {
        [
            defaultTextView, noHelperLabelTextView, errorTextView, disabledTextView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    override func setViewLayouts() {
        defaultTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.lessThanOrEqualTo(100)
            $0.height.greaterThanOrEqualTo(100)
        }
        noHelperLabelTextView.snp.makeConstraints {
            $0.top.equalTo(defaultTextView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.lessThanOrEqualTo(100)
            $0.height.greaterThanOrEqualTo(100)
        }
        errorTextView.snp.makeConstraints {
            $0.top.equalTo(noHelperLabelTextView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(80)
        }
        disabledTextView.snp.makeConstraints {
            $0.top.equalTo(errorTextView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}

extension TextViewController: HandyTextViewEditingDelegate {
    func handyTextViewDidBeginEditing(_ handyTextView: HandyTextView) {
        print("입력 시작")
    }

    func handyTextViewDidEndEditing(_ handyTextView: HandyTextView) {
        print("입력 끝")
    }
}

extension TextViewController: HandyTextViewValidationDelegate {
    func handyTextView(_ handyTextView: HandyTextView, isValidText text: String) -> Bool {
        let regex = "^[a-zA-Z0-9]*$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
    }

    func handyTextView(_ handyTextView: HandyTextView, didFailValidationWithError error: String) {
        print("유효성 검사 에러: \(error)")
    }
}

extension TextViewController: HandyTextViewTextChangeDelegate {
    func handyTextViewDidChange(_ handyTextView: HandyTextView, text: String) {
        print("입력된 텍스트: \(text)")
    }
}

