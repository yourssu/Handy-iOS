//
//  HandyBaseTextField.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit

public class HandyBaseTextField: UITextField {

    // MARK: - 외부에서 지정할 수 있는 속성

    /**
     텍스트 필드를 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(.layout) public var isDisabled: Bool = false {
        didSet {
            updateState()
        }
    }

    /**
     텍스트 필드의 오류 상태를 나타낼 때 사용합니다.
     */
    @Invalidating(.layout) public var isNegative: Bool = false {
        didSet {
            updateState()
        }
    }

    // MARK: - 내부에서 사용되는 뷰

    /**
     텍스트 필드 내의 입력을 초기화할 때 사용하는 Clear 버튼입니다.
     */
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(HandyIcon.cancelFilled, for: .normal)
        button.tintColor = HandySemantic.iconBasicTertiary
        button.isHidden = true
        return button
    }()

    // MARK: - 초기화

    /**
     초기화 메소드입니다. 기본적인 텍스트 필드 속성과 Clear 버튼을 설정합니다.
     */
    public init() {
        super.init(frame: .zero)
        setupTextField()
        updatePlaceholderColorAndFont()
        setupClearButton()
        self.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - 설정

    /**
     텍스트 필드의 기본 속성을 설정합니다.
     - 테두리 색상, 패딩, 기본 배경색 등을 포함합니다.
     */
    private func setupTextField() {
        self.tintColor = HandySemantic.lineStatusPositive
        self.layer.cornerRadius = HandySemantic.radiusM
        self.layer.borderWidth = 1
        self.layer.borderColor = HandySemantic.bgBasicLight.cgColor
        self.backgroundColor = HandySemantic.bgBasicLight
        self.clipsToBounds = true
        self.font = HandyFont.B1Rg16

        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: HandyTextFieldConstants.Dimension.leftMargin, height: 0))
        self.leftView = leftPaddingView
        self.leftViewMode = .always

        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: HandyTextFieldConstants.Dimension.rightMargin, height: 0))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
        
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(HandyTextFieldConstants.Dimension.textFieldHeight)
        }
    }
    
    /**
     플레이스홀더의 색상과 폰트를 업데이트합니다.
     - 기본적으로 `HandyFont.B1Rg16`를 사용하며, `color` 매개변수를 통해 색상을 지정할 수 있습니다.
     */
    private func updatePlaceholderColorAndFont(color: UIColor = HandySemantic.textBasicTertiary) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: HandyFont.B1Rg16
        ]

        if let placeholder = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        }
    }

    /**
     Clear 버튼을 설정합니다.
     - Clear 버튼은 텍스트 필드 오른쪽에 위치하며, 텍스트 입력 상태에 따라 표시됩니다.
     */
    private func setupClearButton() {
        addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)

        clearButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(HandyTextFieldConstants.Dimension.clearButtonDefaultRightMargin)
            $0.width.height.equalTo(HandyTextFieldConstants.Dimension.clearButtonSize)
        }

        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }

    // MARK: - 상태 관리

    /**
     텍스트 필드의 상태에 따라 UI를 업데이트합니다.
     - `isDisabled`: 비활성화 상태를 나타냅니다.
     - `isNegative`: 오류 상태를 나타냅니다.
     */
    private func updateState() {
        if isDisabled {
            self.isUserInteractionEnabled = false
            self.backgroundColor = HandySemantic.bgBasicLight
            self.layer.borderColor = HandySemantic.bgBasicLight.cgColor
            self.textColor = HandySemantic.textBasicDisabled
            updatePlaceholderColorAndFont(color: HandySemantic.textBasicDisabled)
            clearButton.isHidden = true
            return
        }

        if isNegative {
            self.isUserInteractionEnabled = true
            self.layer.borderColor = HandySemantic.lineStatusNegative.cgColor
            self.textColor = HandySemantic.textBasicSecondary
            updatePlaceholderColorAndFont(color: HandySemantic.textBasicTertiary)
            clearButton.isHidden = false
            return
        }

        self.isUserInteractionEnabled = true
        self.layer.borderColor = HandySemantic.bgBasicLight.cgColor
        self.textColor = HandySemantic.textBasicPrimary
        updatePlaceholderColorAndFont(color: HandySemantic.textBasicTertiary)
        clearButton.isHidden = self.text?.isEmpty ?? true
    }

    // MARK: - Clear 버튼 동작

    /**
     텍스트 필드의 텍스트를 초기화합니다.
     - Clear 버튼이 눌렸을 때 호출됩니다.
     */
    @objc private func clearText() {
        self.text = ""
        clearButton.isHidden = true
    }

    /**
     텍스트 필드의 텍스트 변경 시 호출됩니다.
     - 텍스트가 입력되거나 삭제될 때 Clear 버튼의 표시 상태를 업데이트합니다.
     */
    @objc private func textDidChange() {
        clearButton.isHidden = self.text?.isEmpty ?? true
    }

    // MARK: - Overridden Methods

    /**
     Placeholder 및 텍스트 레이아웃을 설정합니다.
     */
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(
            top: 0,
            left: HandyTextFieldConstants.Dimension.leftMargin,
            bottom: 0,
            right: HandyTextFieldConstants.Dimension.rightMargin
        ))
    }

    /**
     텍스트 입력 시 레이아웃을 설정합니다.
     */
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(
            top: 0,
            left: HandyTextFieldConstants.Dimension.leftMargin,
            bottom: 0,
            right: HandyTextFieldConstants.Dimension.rightMargin
        ))
    }
}

// MARK: - UITextFieldDelegate

extension HandyBaseTextField: UITextFieldDelegate {
    /**
     텍스트 필드가 편집을 시작할 때 호출됩니다.
     - isNegative 상태가 아닐 경우, 테두리 색상을 긍정 상태 색상으로 변경합니다.
     - 편집 중일 때 시각적 피드백을 제공합니다.
     - 호출 시점: 사용자가 텍스트 필드에 포커스를 줄 때.
     */
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if !isNegative {
            self.layer.borderColor =  HandySemantic.lineStatusPositive.cgColor
        }
    }
    
    /**
     텍스트 필드의 편집이 종료될 때 호출됩니다.
     - 상태를 다시 업데이트하여 현재 상태에 맞는 UI를 반영합니다.
     - 호출 시점: 사용자가 텍스트 필드의 포커스를 해제할 때.
     */
    public func textFieldDidEndEditing(_ textField: UITextField) {
        updateState()
    }
}

