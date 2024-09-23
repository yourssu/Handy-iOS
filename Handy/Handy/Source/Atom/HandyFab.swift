//
//  HandyFab.swift
//  Handy
//
//  Created by 정민지 on 7/31/24.
//

import UIKit

public class HandyFab: UIButton {

    // MARK: - 외부에서 지정할 수 있는 속성

    /**
     Fab 버튼을 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(.layout, .display) public var isDisabled: Bool = false {
        didSet {
            setConfiguration()
        }
    }
    
    /**
     Fab 버튼의 Pressed / Hover 여부를 나타낼 때 사용합니다.
     */
    public override var isHighlighted: Bool {
        didSet { setConfiguration() }
    }

    /**
     Fab 버튼의 타입을 결정할 때 사용합니다.
     */
    @Invalidating(.layout, .display) public var type: FabType = .primary {
        didSet {
            setConfiguration()
        }
    }

    /**
     Fab 버튼의 크기를 결정할 때 사용합니다.
     */
    @Invalidating(.layout, .display) public var size: FabSize = .large {
        didSet {
            setConfiguration()
        }
    }
    
    /**
     Fab 버튼의 아이콘을 설정할 때 사용합니다.
    */
    public var iconImage: UIImage? {
        didSet {
            setConfiguration()
        }
    }

    // MARK: - 외부에서 접근할 수 있는 enum

    /**
     Fab 버튼의 type 종류입니다.
     각 type에 맞는 borderColor, backgroundColor를  computed property로 가지고 있습니다.
     */
    public enum FabType {
        case primary
        case secondary
        
        var backgroundColor: UIColor {
            switch self {
            case .primary:
                return HandySemantic.buttonFabPrimaryEnabled
            case .secondary:
                return HandySemantic.buttonFabSecondaryEnabled
            }
        }
        
        var highlightedColor: UIColor {
            switch self {
            case .primary:
                return HandySemantic.buttonFabPrimaryPressed
            case .secondary:
                return HandySemantic.buttonFabSecondaryPressed
            }
        }
        
        var disabledColor: UIColor {
            switch self {
            case .primary:
                return HandySemantic.buttonFabPrimaryDisabled
            case .secondary:
                return HandySemantic.buttonFabSecondaryDisabled
            }
        }
        
        var borderColor: UIColor {
            switch self {
            case .primary:
                return .clear
            case .secondary:
                return  HandySemantic.lineBasicLight
            }
        }
        
        var shadowColor: UIColor {
            switch self {
            case .primary:
                return UIColor(
                    red: 110/255,
                    green: 118/255,
                    blue: 135/255,
                    alpha: 0.25
                )
            case .secondary:
                return UIColor(
                    red: 181/255,
                    green: 185/255,
                    blue: 196/255,
                    alpha: 0.25
                )
            }
        }
    }

    /**
     Fab 버튼의 size 종류입니다.
     각 size에 맞는 icon을 computed property로 가지고 있습니다.
     */
    public enum FabSize {
        case small
        case large

        fileprivate var fabSize: CGFloat {
            switch self {
            case .small:
                return 40
            case .large:
                return 56
            }
        }
        
        fileprivate var icon: String {
            switch self {
            case .small:
                return "arrow.up"
            case .large:
                return "square.and.arrow.up"
            }
        }
    }

    // MARK: - 메소드

    public init() {
        super.init(frame: .zero)
        setConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConfiguration() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.fabSize),
            heightAnchor.constraint(equalToConstant: size.fabSize)
        ])
        self.layer.cornerRadius = size.fabSize / 2
        self.layer.borderWidth = type == .secondary ? 1 : 0

        var configuration = UIButton.Configuration.plain()

        let iconConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        let iconImage = iconImage == nil ? UIImage(
            systemName: size.icon,
            withConfiguration: iconConfig
        ): iconImage
        
//        TODO: - HandyIcon으로 아이콘 변경, pointSize 삭제, resize 적용(아래 코드로 교체)
//        var iconConfig = iconImage == nil ? UIImage(systemName: size.icon): iconImage
//        iconConfig = iconConfig?.resize(to: 24)
        

        var iconColor: UIColor = type == .secondary ? HandySemantic.iconBasicTertiary : HandySemantic.iconBasicWhite
        switch (isDisabled, isHighlighted) {
        case (true, _):
            self.backgroundColor = type.disabledColor
            self.layer.borderColor = type.borderColor.cgColor
            iconColor = type == .secondary ? HandySemantic.iconBasicDisabled : HandySemantic.iconBasicWhite
            removeShadow()

        case (false, true):
            self.backgroundColor = type.highlightedColor
            self.layer.borderColor = type.borderColor.cgColor
            applyShadow()

        case (false, false):
            self.backgroundColor = type.backgroundColor
            self.layer.borderColor = type.borderColor.cgColor
            applyShadow()
        }
        
        configuration.image = iconImage?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
        
        self.isEnabled = !isDisabled
        self.configuration = configuration
    }

    private func applyShadow() {
        layer.shadowColor = type.shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowOpacity = 1.0
    }

    private func removeShadow() {
        layer.shadowOpacity = 0.0
    }
}
