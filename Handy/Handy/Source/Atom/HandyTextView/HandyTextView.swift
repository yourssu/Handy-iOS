//
//  HandyTextView.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit
import SnapKit

public class HandyTextView: UIView {
    // MARK: - 외부에서 지정할 수 있는 속성
    
    /**
     텍스트 필드를 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(wrappedValue: false, .display) public var isDisabled: Bool
    
    /**
     텍스트 필드의 오류 상태를 나타낼 때 사용합니다.
     */
    @Invalidating(wrappedValue: false, .display) public var isNegative: Bool
    
    /**
     텍스트 필드의 텍스트를 설정하거나 가져올때 사용합니다.
     */
    public var text: String? {
        get { return textView.text }
        set { textView.text = newValue }
    }
    
    /**
     텍스트 필드의 Placeholder를 설정합니다.
     */
    public var placeholder: String? {
        get { return textView.placeholder }
        set { textView.placeholder = newValue }
    }
    
    /**
     플레이스홀더 색상을 설정할때 사용합니다.
     */
    public var placeholderColor: UIColor {
        get { return textView.placeholderColor }
        set { textView.placeholderColor = newValue }
    }
    
    /**
     하단 헬퍼 라벨의 텍스트를 설정할때 사용합니다.
     - 값이 `nil`일 경우 라벨이 숨겨집니다.
     */
    public var helperLabelText: String? {
        get { return helperLabel.text }
        set {
            helperLabel.text = newValue
            helperLabel.isHidden = newValue == nil
        }
    }
    
    // MARK: - 내부에서 사용되는 컴포넌트
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = HandyTextViewConstants.Dimension.subviewSpacing
        stackView.alignment = .fill
        return stackView
    }()
    
    public let textView = HandyBaseTextView()
    private let helperLabelContainer = UIView()
    private let helperLabel = HandyLabel(style: .B5Rg12)
    
    // MARK: - 초기화
    
    public init() {
        super.init(frame: .zero)
        setupView()
        updateState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 메소드
    
    private func setupView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }

        stackView.addArrangedSubview(textView)
        
        if !helperLabel.isHidden {
            stackView.addArrangedSubview(helperLabelContainer)
            
            helperLabelContainer.addSubview(helperLabel)
            helperLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(HandyTextViewConstants.Dimension.labelInsetWidth)
                $0.top.verticalEdges.equalToSuperview()
            }
            
            let textViewHeight = HandyTextViewConstants.Dimension.textViewHeight
            let helperLabelHeight = HandyTextViewConstants.Dimension.helperLabelHeight
            let subviewSpacing = HandyTextViewConstants.Dimension.subviewSpacing
            
            self.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(textViewHeight + helperLabelHeight + subviewSpacing)
            }
        } else {
            self.snp.makeConstraints {
                $0.height.greaterThanOrEqualTo(HandyTextViewConstants.Dimension.textViewHeight)
            }
        }
    }
    
    private func updateState() {
        textView.isDisabled = isDisabled
        textView.isNegative = isNegative
        helperLabel.textColor = isNegative ? HandySemantic.lineStatusNegative : HandySemantic.textBasicTertiary
        
    }
    
    // MARK: - Overridden Methods

    public override func layoutSubviews() {
        super.updateConstraints()
        
        let maxConstraints = self.constraints.filter {
            $0.firstAttribute == .height && $0.relation == .lessThanOrEqual
        }
        
        if !maxConstraints.isEmpty {
            maxConstraints.forEach { maxConstraint in
                let helperHeight =  helperLabel.isHidden ? 0 : (
                    HandyTextViewConstants.Dimension.helperLabelHeight + HandyTextViewConstants.Dimension.subviewSpacing
                )
                textView.maxHeight = maxConstraint.constant - helperHeight
            }
        }
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateState()
    }
}
