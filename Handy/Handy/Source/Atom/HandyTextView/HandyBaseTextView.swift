//
//  HandyBaseTextView.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit
import SnapKit

public class HandyBaseTextView: UITextView {
    // MARK: - 외부에서 지정할 수 있는 속성
    
    /**
     텍스트 뷰를 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(wrappedValue: false, .display) public var isDisabled: Bool
    
    /**
     텍스트 필드의 오류 상태를 나타낼 때 사용합니다.
     */
    @Invalidating(wrappedValue: false, .display) public var isNegative: Bool
    
    /**
     텍스트 뷰의 플레이스홀더를 설정할 때 사용합니다.
     */
    public var placeholder: String? {
        didSet { setupPlaceholder() }
    }
    
    /**
     플레이스홀더 텍스트 색상을 설정할 때 사용합니다.
     */
    public var placeholderColor: UIColor = HandySemantic.textBasicTertiary {
        didSet {
            placeholderLabel?.textColor = placeholderColor
        }
    }
    
    public var maxHeight: CGFloat? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    /**
     플레이스홀더 텍스트를 설정할 때 사용합니다.
     */
    private var placeholderLabel: UILabel?
    
    // MARK: - 메소드
    
    public init() {
        super.init(frame: .zero, textContainer: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.delegate = self
        self.font = HandyFont.B3Rg14
        self.backgroundColor = HandySemantic.bgBasicLight
        self.isScrollEnabled = true
        self.layer.borderWidth = 1
        self.layer.cornerRadius = HandySemantic.radiusM
        self.layer.masksToBounds = true
        self.layer.borderColor = HandySemantic.bgBasicLight.cgColor
        self.textContainer.lineFragmentPadding = 0
        self.textContainerInset = UIEdgeInsets(
            top: HandyTextViewConstants.Dimension.textContainerInset,
            left: HandyTextViewConstants.Dimension.textContainerInset,
            bottom: HandyTextViewConstants.Dimension.textContainerInset,
            right: HandyTextViewConstants.Dimension.textContainerInset
        )
    }
    
    private func setupPlaceholder() {
        if placeholderLabel == nil {
            placeholderLabel = UILabel()
            placeholderLabel?.textColor = placeholderColor
            placeholderLabel?.font = self.font
            placeholderLabel?.numberOfLines = 0
            placeholderLabel?.text = placeholder
            guard let label = placeholderLabel else { return }
            self.addSubview(label)
            
            label.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(textContainerInset)
            }
        } else {
            placeholderLabel?.text = placeholder
        }
    }
    
    private func updateState() {
        self.layer.cornerRadius = HandySemantic.radiusM
        self.layer.masksToBounds = true
        
        if isDisabled {
            self.isEditable = false
            self.layer.borderColor = HandySemantic.bgBasicLight.cgColor
            placeholderLabel?.textColor = HandySemantic.textBasicDisabled
        } else if isNegative {
            self.isEditable = true
            self.layer.borderColor = HandySemantic.lineStatusNegative.cgColor
            placeholderLabel?.textColor = HandySemantic.textBasicTertiary
        } else {
            self.isEditable = true
            self.layer.borderColor = HandySemantic.bgBasicLight.cgColor
            placeholderLabel?.textColor = HandySemantic.textBasicTertiary
        }
    }
    
    private func textDidChange() {
        placeholderLabel?.isHidden = !text.isEmpty
    }
    
    // MARK: - Overridden Methods
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        updateState()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if let maxHeight = maxHeight {
            isScrollEnabled = contentSize.height > maxHeight
            
            scrollIndicatorInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: HandyTextViewConstants.Dimension.scrollIndicatorInsets
            )
        } else {
            isScrollEnabled = false
        }
    }
}

// MARK: - UITextViewDelegate

extension HandyBaseTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if !isNegative {
            self.layer.borderColor = HandySemantic.lineStatusPositive.cgColor
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        updateState()
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        textDidChange()
    }
}
