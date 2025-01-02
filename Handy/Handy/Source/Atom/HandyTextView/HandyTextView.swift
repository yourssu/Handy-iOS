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
    @Invalidating(.layout) public var isDisabled: Bool = false {
        didSet { updateState() }
    }

    /**
     텍스트 필드의 오류 상태를 나타낼 때 사용합니다.
     */
    @Invalidating(.layout) public var isNegative: Bool = false {
        didSet { updateState() }
    }
    
    /**
     텍스트 뷰의 최소 높이를 설정합니다.
     */
    public var minHeight: CGFloat? {
        didSet {
            guard let minHeight = minHeight else { return }
            textView.snp.updateConstraints {
                $0.height.greaterThanOrEqualTo(minHeight)
            }
        }
    }
    
    /**
     텍스트 뷰의 최대 높이를 설정합니다.
     */
    public var maxHeight: CGFloat? {
        get { return textView.maxHeight }
        set { textView.maxHeight = newValue }
    }

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

    // MARK: - 메소드

    public init() {
        super.init(frame: .zero)
        setupView()
        updateState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { $0.edges.equalToSuperview()}
        
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(helperLabelContainer)
        
        textView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(minHeight ?? HandyTextViewConstants.Dimension.textViewHeight)
            if let maxHeight = maxHeight {
                $0.height.lessThanOrEqualTo(maxHeight)
            }
        }
        helperLabelContainer.addSubview(helperLabel)
        helperLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(HandyTextViewConstants.Dimension.labelInsetWidth)
            $0.top.verticalEdges.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(minHeight ?? HandyTextViewConstants.Dimension.textViewHeight)
        }
    }
    
    private func updateState() {
        textView.isDisabled = isDisabled
        textView.isNegative = isNegative
        helperLabel.textColor = isNegative ? HandySemantic.lineStatusNegative : HandySemantic.textBasicTertiary
    }
}
