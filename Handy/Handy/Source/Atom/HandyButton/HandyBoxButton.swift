//
//  HandyBoxButton.swift
//  Handy
//
//  Created by 이조은 on 7/25/24.
//

import UIKit
import SnapKit

public class HandyBoxButton: UIButton, HandyButtonProtocol {

    // MARK: - 외부에서 지정할 수 있는 속성

    /**
     버튼을 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(.layout, .display) public var isDisabled: Bool = false

    /**
     삭제, 탈퇴 등 파괴적인 행위를 할 때
     버튼을 빨간색으로 표시해 경고하기 위해 사용합니다.
     */
    @Invalidating(.display) public var isWarned: Bool = false

    /**
     버튼의 외관을 결정할 때 사용합니다.
     */
    @Invalidating(.display) public var type: BoxButtonType = .primary

    /**
     버튼의 높이, 타이포 크기, 아이콘 크기, 패딩을 결정할 때 사용합니다.
     */
    @Invalidating(.display) public var size: BoxButtonSize = .large

    /**
     버튼의 라운딩을 결정할 때 사용합니다.
     */
    @Invalidating(.layout) public var rounding: BoxButtonRounding = .r12

    /**
     버튼의 글귀를 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: nil, .layout, .display) public var text: String?

    /**
     버튼의 좌측에 들어갈 아이콘을 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: nil, .display) public var leftIcon: UIImage?

    /**
     버튼의 우측에 들어갈 아이콘을 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: nil, .display) public var rightIcon: UIImage?

    /**
     기본 속성을 override한 후 didSet을 설정하여
     값이 바뀔 때 ( = 버튼을 누르거나 땠을 때 ) 그에 맞춰 색을 바꿔줍니다.
     */
    public override var isHighlighted: Bool {
        didSet { setNeedsDisplay() }
    }

    // MARK: - 외부에서 접근할 수 있는 enum

    /**
     버튼의 type 종류입니다.
     */
    public enum BoxButtonType {
        case primary
        case secondary
        case tertiary
    }

    /**
     버튼의 size 종류입니다.
     각 size에 맞는 height, padding, font, iconSize를 computed property로 가지고 있습니다.
     */
    public enum BoxButtonSize {
        case xLarge
        case large
        case medium
        case small
        case xSmall
        case xxSmall

        fileprivate var height: CGFloat {
            switch self {
            case .xLarge:
                return 56
            case .large:
                return 52
            case .medium:
                return 48
            case .small:
                return 40
            case .xSmall:
                return 32
            case .xxSmall:
                return 24
            }
        }

        fileprivate var width: CGFloat {
            switch self {
            case .xLarge, .large:
                return 136
            case .medium:
                return 128
            case .small:
                return 114
            case .xSmall:
                return 84
            case .xxSmall:
                return 80
            }
        }

        fileprivate var padding: CGFloat {
            switch self {
            case .xLarge, .large, .medium, .small:
                return 16
            case .xSmall, .xxSmall:
                return 8
            }
        }

        fileprivate var font: UIFont {
            switch self {
            case .xLarge, .large, .medium:
                return HandyFont.B1Sb16
            case .small:
                return HandyFont.B3Sb14
            case .xSmall, .xxSmall:
                return HandyFont.B5Sb12
            }
        }

        fileprivate var iconSize: CGFloat {
            switch self {
            case .xLarge, .large, .medium:
                return 20
            case .small:
                return 16
            case .xSmall, .xxSmall:
                return 12
            }
        }

        /**
         버튼 내 요소 사이 간격입니다. icon과 titleLabel 사이 간격에 사용됩니다.
         */
        fileprivate var subviewSpacing: CGFloat {
            switch self {
            case .xLarge, .large, .medium, .small, .xSmall:
                return 4
            case .xxSmall:
                return 2
            }
        }
    }

    // MARK: - 추후 변경 필요 ⭐️
    /**
     버튼의 rounding 값 종류입니다.
     */
    public enum BoxButtonRounding: Int {
        case r8 = 8
        case r10 = 10
        case r12 = 12
        case r14 = 14
        case r16 = 16
    }

    // MARK: - 내부에서 사용되는 변수

    /**
     버튼의 아이콘, 글자 컬러입니다.
     */
    private var fgColor: UIColor?

    /**
     버튼이 pressed 되었을 때 아이콘, 글자 컬러입니다.
     */
    private var fgPressedColor: UIColor?

    /**
     버튼의 배경 컬러입니다.
     */
    private var bgColor: UIColor?

    /**
     버튼이 pressed 되었을 때 배경 컬러입니다.
     */
    private var bgPressedColor: UIColor?

    /**
     버튼의 border 컬러입니다.
     */
    private var borderColor: UIColor?

    /**
     버튼이 pressed 되었을 때 border 컬러입니다.
     */
    private var borderPressedColor: UIColor?

    /**
     버튼의 borderWidth입니다.
     */
    private var borderWidth: CGFloat = 0

    // MARK: - 메소드

    public init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     view를 세팅합니다.
     */
    private func setupView() {
        self.clipsToBounds = true
        self.adjustsImageWhenHighlighted = false
        self.adjustsImageWhenDisabled = false

        setBoxButtonSize()
        setBoxButtonColor()
        setBoxButtonRounding()
    }

    /**
     버튼의 컬러 조합을 세팅합니다.
     */
    private func setBoxButtonColor() {
        switch type {
        case .primary:
            borderColor = nil
            borderPressedColor = nil
            borderWidth = 0

            if isDisabled {
                fgColor = HandySemantic.textBasicDisabled
                fgPressedColor = HandySemantic.textBasicDisabled
                bgColor = HandySemantic.buttonBoxPrimaryDisabled
                bgPressedColor = HandySemantic.buttonBoxPrimaryDisabled
            } else {
                fgColor = HandySemantic.textBasicWhite
                fgPressedColor = HandySemantic.textBasicWhite
                bgColor = HandySemantic.buttonBoxPrimaryEnabled
                bgPressedColor = HandySemantic.buttonBoxPrimaryPressed
            }

        case .secondary:
            borderColor = nil
            borderPressedColor = nil
            borderWidth = 0

            if isDisabled {
                fgColor = HandySemantic.textBasicDisabled
                fgPressedColor = HandySemantic.textBasicDisabled
                bgColor = HandySemantic.buttonBoxPrimaryDisabled
                bgPressedColor = HandySemantic.buttonBoxPrimaryDisabled
            } else {
                fgColor = HandySemantic.textBrandSecondary
                fgPressedColor = HandySemantic.textBrandSecondary
                bgColor = HandySemantic.buttonBoxSecondaryEnabled
                bgPressedColor = HandySemantic.buttonBoxSecondaryPressed
            }

        case .tertiary:
            bgColor = nil
            bgPressedColor = nil
            borderWidth = 1

            if isDisabled {
                fgColor = HandySemantic.textBasicDisabled
                fgPressedColor = HandySemantic.textBasicDisabled
                bgColor = HandySemantic.buttonBoxPrimaryDisabled
                bgPressedColor = HandySemantic.buttonBoxPrimaryDisabled
                borderColor = HandySemantic.textBasicDisabled
            } else {
                fgColor = HandySemantic.buttonBoxTertiaryDisabled
                fgPressedColor = HandySemantic.buttonBoxTertiaryDisabled
                bgColor = HandySemantic.buttonBoxTertiaryEnabled
                bgPressedColor = HandySemantic.buttonBoxTertiaryPressed
                borderColor = HandySemantic.lineBasicMedium
            }
        }

        setTitleColor(fgColor, for: .normal)
        setTitleColor(fgPressedColor, for: .highlighted)

        setTintColorBasedOnIsHighlighted()

        setBackgroundColor(bgColor, for: .normal)
        setBackgroundColor(bgPressedColor, for: .highlighted)

        self.layer.borderWidth = borderWidth
        setBorderColorBasedOnIsHighlighted()
    }

    /**
     isHighlighted 값에 맞추어 tintColor를 변경합니다.
     */
    private func setTintColorBasedOnIsHighlighted() {
        self.tintColor = !isHighlighted
            ? fgColor
            : fgPressedColor
    }

    /**
     isHighlighted 값에 맞추어 borderColor를 변경합니다.
     */
    private func setBorderColorBasedOnIsHighlighted() {
        self.layer.borderColor = !isHighlighted
            ? borderColor?.cgColor
            : borderPressedColor?.cgColor
    }

    /**
     버튼의 라운딩 값을 세팅합니다.
     */
    private func setBoxButtonRounding() {
        self.layer.cornerRadius = CGFloat(rounding.rawValue)
    }

    /**
     버튼의 높이, 패딩, 폰트, 아이콘 크기를 세팅합니다.
     */
    private func setBoxButtonSize() {
        self.snp.updateConstraints {
            $0.height.equalTo(size.height)
        }

        self.titleLabel?.font = size.font
        setIcon()
    }

    /**
     버튼의 아이콘 위치와 그에 따른 패딩을 설정합니다.
     우선순위는 leftIcon > rightIcon 입니다.
     */
    private func setIcon() {
        setIconImage()
        setLayoutAccordingToIcon()
    }

    /**
     버튼의 아이콘 이미지를 설정합니다.
     leftIcon이 존재할 경우 leftIcon을
     leftIcon이 존재하지 않으면서 rightIcon이 존재할 경우 rightIcon을
     둘 다 존재하지 않을 경우 nil을 채택합니다.
     */
    private func setIconImage() {
        if leftIcon != nil {
            self.setImage(self.leftIcon?
                            .resize(to: size.iconSize)
                            .withRenderingMode(.alwaysTemplate),
                          for: .normal)
            return
        }

        if rightIcon != nil {
            self.setImage(self.rightIcon?
                            .resize(to: size.iconSize)
                            .withRenderingMode(.alwaysTemplate),
                          for: .normal)
            return
        }

        self.setImage(nil, for: .normal)
    }

    /**
     아이콘 설정에 따른 버튼의 레이아웃을 결정합니다.
     */
    private func setLayoutAccordingToIcon() {
        if leftIcon != nil && text != nil {
            //  leftIcon != nil 이면서 text != nil인
            //  2가지 경우에 대응합니다.

            self.semanticContentAttribute = .forceLeftToRight
            self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                left: -size.subviewSpacing/2,
                                                bottom: 0,
                                                right: size.subviewSpacing/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                left: size.subviewSpacing/2,
                                                bottom: 0,
                                                right: -size.subviewSpacing/2)
            self.contentEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: size.padding+size.subviewSpacing/2,
                                                  bottom: 0,
                                                  right: size.padding+size.subviewSpacing/2)
            return
        }

        if rightIcon != nil && text != nil {
            //  위에서 걸러지지 않은 6가지 경우 중
            //  rightIcon != nil 이면서 text != nil 인
            //  1가지 경우에 대응합니다.

            self.semanticContentAttribute = .forceRightToLeft
            self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                left: size.subviewSpacing/2,
                                                bottom: 0,
                                                right: -size.subviewSpacing/2)
            self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                left: -size.subviewSpacing/2,
                                                bottom: 0,
                                                right: size.subviewSpacing/2)
            self.contentEdgeInsets = UIEdgeInsets(top: 0,
                                                  left: size.padding+size.subviewSpacing/2,
                                                  bottom: 0,
                                                  right: size.padding+size.subviewSpacing/2)
            return
        }

        //  위에서 걸러지지 않은 5가지 경우
        //  text == nil 인 경우 4가지
        //  leftIcon == nil && rightIcon == nil 인 경우 2가지
        //  둘의 합집합 5가지에 대응합니다.
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: size.padding, bottom: 0, right: size.padding)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        isEnabled = !isDisabled
        setTitle(text, for: .normal)
        setBoxButtonRounding()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        setBoxButtonColor()
        setBoxButtonSize()
    }
}

extension UIButton {
    internal func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 1.0, height: 1.0))

        let image = render.image { context in
            if let color = color {
                color.setFill()
            } else {
                UIColor.clear.setFill()
            }
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        }

        self.setBackgroundImage(image, for: state)
    }
}

