//
//  HandyTextField.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit
import SnapKit

public class HandyTextFieldView: UIView {
    
    // MARK: - 외부에서 지정할 수 있는 속성
    
    /**
     텍스트 필드를 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(wrappedValue: false, .display) public var isDisabled: Bool
    
    /**
     텍스트 필드의 오류 상태를 표현할 때 사용합니다.
     */
    @Invalidating(wrappedValue: false, .display) public var isNegative: Bool
    
    /**
     텍스트 필드의 텍스트를 설정하거나 가져올 때 사용합니다.
     */
    public var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    /**
     텍스트 필드의 Placeholder를 설정할 때 사용합니다.
     */
    public var placeholder: String? {
        get { return textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    /**
     상단 라벨 텍스트를 설정하거나 가져올 때 사용합니다.
     - 값이 `nil`일 경우 라벨이 숨겨집니다.
     */
    public var fieldLabelText: String? {
        get { return fieldLabel.text }
        set {
            fieldLabel.text = newValue
            fieldLabel.isHidden = newValue == nil
        }
    }
    
    /**
     하단 헬퍼 라벨 텍스트를 설정하거나 가져올 때 사용합니다.
     - 값이 `nil`일 경우 라벨이 숨겨집니다.
     */
    public var helperLabelText: String? {
        get { return helperLabel.text }
        set {
            helperLabel.text = newValue
            helperLabel.isHidden = newValue == nil
        }
    }
    
    // MARK: - UI 구성 요소
    
    /**
     텍스트 필드와 라벨들을 담고 있는 스택 뷰입니다.
     */
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = HandyTextFieldConstants.Dimension.subviewSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    /**
     텍스트 필드 상단에 위치한 라벨입니다.
     */
    private let fieldLabelContainer = UIView()
    
    private let fieldLabel = HandyLabel(style: .B5Rg12)
    
    /**
     사용자 입력을 위한 기본 텍스트 필드입니다.
     - 내부적으로 `HandyBaseTextField`를 사용하여 Clear 버튼 및 상태 관리를 포함합니다.
     */
    public let textField = HandyBaseTextField()
    
    /**
     텍스트 필드 하단에 위치한 헬퍼 라벨입니다.
     */
    private let helperLabelContainer = UIView()
    
    private let helperLabel = HandyLabel(style: .B5Rg12)
    
    // MARK: - 초기화
    
    /**
     초기화 메소드입니다. 기본적으로 뷰의 UI 구성 요소를 설정합니다.
     */
    public init() {
        super.init(frame: .zero)
        setupView()
        updateState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 뷰 구성
    
    /**
     뷰의 기본 UI 요소를 설정하고 제약 조건을 추가합니다.
     */
    private func setupView() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(fieldLabelContainer)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(helperLabelContainer)
        
        fieldLabelContainer.addSubview(fieldLabel)
        fieldLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(HandyTextFieldConstants.Dimension.labelInsetWidth)
            $0.trailing.verticalEdges.equalToSuperview()
        }
        
        helperLabelContainer.addSubview(helperLabel)
        helperLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(HandyTextFieldConstants.Dimension.labelInsetWidth)
            $0.trailing.verticalEdges.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(HandyTextFieldConstants.Dimension.textFieldHeight)
        }
    }
    
    // MARK: - 상태 관리
    
    /**
     `isDisabled` 및 `isNegative` 속성에 따라 라벨과 텍스트 필드 상태를 업데이트합니다.
     */
    private func updateState() {
        textField.isDisabled = isDisabled
        textField.isNegative = isNegative
        
        fieldLabel.textColor = HandySemantic.textBasicTertiary
        helperLabel.textColor = HandySemantic.textBasicTertiary
        
        if isNegative {
            helperLabel.textColor = HandySemantic.lineStatusNegative
        }
    }
    
    // MARK: - Overridden Methods
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateState()
    }
}

