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
        textView.helperLabelText = "Helper text"
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
