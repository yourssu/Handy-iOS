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
     텍스트 뷰의 최소 높이를 설정할 때 사용합니다.
     */
    @Invalidating(.layout) public var minHeight: CGFloat? = 48
    
    /**
     텍스트 뷰의 최대 높이를 설정할 때 사용합니다.
     */
    @Invalidating(.layout) public var maxHeight: CGFloat? = nil
    
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
        self.isScrollEnabled = false
        self.layer.cornerRadius = HandySemantic.radiusM
        self.layer.borderWidth = 1
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
    
  
    public override func layoutSubviews() {
        super.layoutSubviews()

        if let minHeight = minHeight, let maxHeight = maxHeight {
            isScrollEnabled = contentSize.height > maxHeight || contentSize.height < minHeight
        } else if let maxHeight = maxHeight {
            isScrollEnabled = contentSize.height > maxHeight
        }

         else if let minHeight = minHeight, bounds.height < minHeight {
            invalidateIntrinsicContentSize()
            frame.size.height = minHeight
        }

        else if let maxHeight = maxHeight, bounds.height > maxHeight {
            invalidateIntrinsicContentSize()
            frame.size.height = maxHeight
        }
        
        scrollIndicatorInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: HandyTextViewConstants.Dimension.scrollIndicatorInsets
        )
    }
    
    private func textDidChange() {
        placeholderLabel?.isHidden = !text.isEmpty
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
