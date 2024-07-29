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
    @Invalidating(wrappedValue: nil, .layout) public var text: String?
    
    private var size: ChipSize = ChipSize()
    
    private struct ChipSize {
        enum SizeType {
            case medium
            case small
        }
        
        var type: SizeType
        
        var height: CGFloat {
            switch type {
            case .medium:
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
        
        init(type: SizeType = .medium) {
            self.type = type
        }
    }
    
    public override var isSelected: Bool {
        didSet { setNeedsLayout() } // 선택되면 다시그려야 함
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
        setColorBasedOnIsSelected()
    }
    
    /**
     isSelected 값의 맞추어 backgroundColor, textColor를 변경합니다.
     */
    private func setColorBasedOnIsSelected() {
        self.backgroundColor = !isSelected
        ? bgColor
        : bgSelectedColor
        
        self.textLabel.textColor = !isSelected
        ? fgColor
        : fgSelectedColor
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
// TODO: Small 사이즈 구현, icon 어떻게 해야하나?, 글자수 제한?, 칩간 행열 간격
