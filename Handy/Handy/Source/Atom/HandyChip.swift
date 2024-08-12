//
//  HandyChip.swift
//  Handy
//
//  Created by 서준영 on 7/22/24.
//

import UIKit

@available(iOS 15, *)

public class HandyChip: UIControl {
    
    // MARK: - 외부에서 지정가능한 속성
    @Invalidating(wrappedValue: nil, .layout) public var text: String? {
        didSet {
            if let text = text, text.count > 10 {
                self.text = String(text.prefix(10))
            }
            setNeedsLayout()
        }
    }
    
    public var size: ChipSize = ChipSize()
    
    public struct ChipSize {
        public enum SizeType {
            case large
            case small
        }
        
        var type: SizeType
        
        var height: CGFloat {
            switch type {
            case .large:
                return 32
            case .small:
                return 24
            }
        }
        
        var cornerRadius: CGFloat {
            return height/2
        }
        
        var padding: CGFloat {
            return 12
        }
        
        public init(type: SizeType = .large) {
            self.type = type
        }
    }
    
    public var chipState: ChipState = ChipState() {
        didSet { setNeedsLayout() }
    }
    
    public struct ChipState {
        public enum StateType {
            case enabled
            case disabled
        }
        
        var type: StateType
        
        public init(type: StateType = .enabled) {
            self.type = type
        }
    }
    
    public override var isSelected: Bool {
        didSet { setNeedsLayout() }
    }
    
    // MARK: - 내부에서 사용되는 함수
    
    /**
     칩의 글자, 아이콘, 배경 컬러입니다. unselected
     */
    private let fgColor: UIColor = HandySemantic.textBasicSecondary
    private let icColor: UIColor = HandySemantic.iconBasicSecondary
    private let bgColor: UIColor = HandySemantic.chipUnselected
    
    /**
     칩이 selected 되었을 때 글자, 아이콘, 배경 컬러입니다.
     */
    private let fgSelectedColor: UIColor = HandySemantic.textBrandPrimary
    private let icSelectedColor: UIColor = HandySemantic.iconBrandPrimary
    private let bgSelectedColor: UIColor = HandySemantic.chipSelected
    
    /**
     칩이 disabled 되었을 때 글자, 아이콘, 배경 컬러입니다.
     */
    private let fgDisabledColor: UIColor = HandySemantic.textBasicDisabled
    private let icDisabledColor: UIColor = HandySemantic.iconBasicDisabled
    private let bgDisabledColor: UIColor = HandySemantic.chipDisabled
    
    /**
     text를 표시하는 Label 입니다.
     */
    private let textLabel = HandyLabel(style: .B3Rg14)
    
    public init() {
        super.init(frame: .zero)
        
        setChipSize()
        setColorBasedOnIsSelected()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        setCornerRadius()
        textLabel.text = text
        setChipSize()
        setColorBasedOnState()
    }
    
    /**
     isSelected 값의 맞추어 backgroundColor, textColor를 변경합니다.
     */
    private func setColorBasedOnIsSelected() {
        self.backgroundColor = isSelected
        ? bgSelectedColor
        : bgColor
        
        self.textLabel.textColor = isSelected
        ? fgSelectedColor
        : fgColor
    }
    
    /**
     Chip의 enabled disabled 상태에 맞추어 세팅합니다.
     */
    private func setColorBasedOnState() {
        switch chipState.type {
        case .enabled:
            setColorBasedOnIsSelected()
        case .disabled:
            self.backgroundColor = bgDisabledColor
            self.textLabel.textColor = fgDisabledColor
        }
    }
    
    /**
     Chip의 높이, Label의 위치를 세팅합니다.
     */
    private func setChipSize() {
        self.addSubview(textLabel)
        
        // 높이 제약 조건 설정
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: size.height)
        heightConstraint.isActive = true

        // textLabel 제약 조건 설정
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerYConstraint = textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let leadingConstraint = textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: size.padding)
        let trailingConstraint = textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -size.padding)
        
        NSLayoutConstraint.activate([centerYConstraint, leadingConstraint, trailingConstraint])
    }
    
    /**
     칩의 cornerRadius를 세팅합니다.
     */
    private func setCornerRadius() {
        self.layer.cornerRadius = size.cornerRadius
    }
}
