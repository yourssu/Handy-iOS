//
//  HandyTextButton.swift
//  Handy
//
//  Created by 이조은 on 7/25/24.
//

import UIKit

public class HandyTextButton: UIButton, HandyButtonProtocol {

    // MARK: - 외부에서 지정할 수 있는 속성

    /**
     버튼을 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(.layout, .display) public var isDisabled: Bool = false

    /**
     버튼의 외관 타입을 결정할 때 사용합니다.
     */
    @Invalidating(.display) public var type: TextButtonType = .primary

    /**
     버튼의 높이, 타이포 크기, 아이콘 크기, 패딩을 결정할 때 사용합니다.
     */
    @Invalidating(.display) public var size: TextButtonSize = .medium

    /**
     Width 버튼의 외관 타입과 상관없이 결정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: nil, .display) public var width: CGFloat?

    /**
     버튼의 글귀를 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: "", .layout, .display) public var text: String

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
    public enum TextButtonType {
        case primary
        case secondary
    }

    /**
     버튼의 size 종류입니다.
     각 size에 맞는 height, width, padding, rounding, typo, iconSize를 computed property로 가지고 있습니다.
     */
    public enum TextButtonSize {
        case medium
        case small
        case xSmall

        fileprivate var height: CGFloat {
            switch self {
            case .medium:
                return 48
            case .small:
                return 40
            case .xSmall:
                return 32
            }
        }

        fileprivate var width: CGFloat {
            switch self {
            case .medium:
                return 48
            case .small:
                return 42
            case .xSmall:
                return 36
            }
        }

        fileprivate var padding: CGFloat {
            switch self {
            case .medium, .small:
                return 8
            case .xSmall:
                return 6
            }
        }

        fileprivate var rounding: Int {
            switch self {
            case .medium, .small, .xSmall:
                return HandySemantic.radiusXS
            }
        }


        fileprivate var typo: String.HandyTypoStyle {
            switch self {
            case .medium:
                return .B3Sb14
            case .small:
                return .B3Sb14
            case .xSmall:
                return .B5Sb12
            }
        }

        fileprivate var iconSize: CGFloat {
            switch self {
            case .medium:
                return 20
            case .small:
                return 16
            case .xSmall:
                return 12
            }
        }

        /**
         버튼 내 요소 사이 간격입니다. icon과 titleLabel 사이 간격에 사용됩니다.
         */
        fileprivate var subviewSpacing: CGFloat {
            switch self {
            case .medium, .small, .xSmall:
                return 4
            }
        }
    }

    // MARK: - 내부에서 사용되는 변수

    /**
     버튼의 스타일과 관련된 설정입니다.
     */
    private var buttonConfiguration = UIButton.Configuration.plain()

    /**
     버튼의 아이콘, 글자 컬러입니다.
     */
    private var fgColor: UIColor?

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

    /**
     레이블
     */
    private let uiStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()

    private var label: HandyLabel =  HandyLabel()

    private var leftImageView: UIImageView = UIImageView()

    private var rightImageView: UIImageView = UIImageView()

    private var isIconSetup = false

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

        setViewHierarchy()
        setButtonLabel()
        setBoxButtonRounding()
        setBoxButtonColor()
    }

    private func setViewHierarchy() {
        self.addSubview(uiStackView)
    }

    /**
     레이블의  색상, 타이포, 텍스트를 설정합니다.
     */
    private func setButtonLabel() {
        label.textColor = self.fgColor
        label.style = size.typo
        label.text = text
    }

    /**
     아이콘 설정에 따른 버튼의 레이아웃을 결정합니다.
     */
    /**
     버튼의  아이콘 크기와 위치를 세팅합니다.
     */
    private func setButtonIcon() {
        if leftIcon != nil && rightIcon != nil {
            leftImageView = UIImageView(image: self.leftIcon?.resize(to: size.iconSize).withRenderingMode(.alwaysTemplate))
            leftImageView.tintColor = self.fgColor

            rightImageView = UIImageView(image: self.rightIcon?.resize(to: size.iconSize).withRenderingMode(.alwaysTemplate))
            rightImageView.tintColor = self.fgColor

            leftImageView.snp.makeConstraints {
                $0.size.equalTo(size.iconSize)
            }

            rightImageView.snp.makeConstraints {
                $0.size.equalTo(size.iconSize)
            }

            uiStackView.addArrangedSubview(leftImageView)
            uiStackView.addArrangedSubview(label)
            uiStackView.addArrangedSubview(rightImageView)

            uiStackView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        } else if leftIcon != nil {
            leftImageView = UIImageView(image: self.leftIcon?.resize(to: size.iconSize).withRenderingMode(.alwaysTemplate))
            leftImageView.tintColor = self.fgColor

            leftImageView.snp.makeConstraints {
                $0.size.equalTo(size.iconSize)
            }

            uiStackView.addArrangedSubview(leftImageView)
            uiStackView.addArrangedSubview(label)

            uiStackView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        } else if rightIcon != nil {
            rightImageView = UIImageView(image: self.rightIcon?.resize(to: size.iconSize).withRenderingMode(.alwaysTemplate))
            rightImageView.tintColor = self.fgColor

            rightImageView.snp.makeConstraints {
                $0.size.equalTo(size.iconSize)
            }

            uiStackView.addArrangedSubview(label)
            uiStackView.addArrangedSubview(rightImageView)

            uiStackView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        } else {
            uiStackView.addArrangedSubview(label)

            uiStackView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }


    /**
     버튼의 높이와 너비를 세팅합니다.
     */
    private func setBoxButtonSize() {
        if width == nil { // 정해진 Width
            if leftIcon != nil && rightIcon != nil {
                width = ((size.width )+(size.iconSize+size.subviewSpacing+size.padding)*2) // 88+
            } else if leftIcon != nil {
                width = ((size.width )+size.iconSize+size.subviewSpacing+size.padding*2)
            } else if rightIcon != nil {
                width = ((size.width)+size.iconSize+size.subviewSpacing+size.padding*2)
            } else {
                width = size.width+(size.padding*2)
            }

            self.snp.makeConstraints {
                $0.height.equalTo(size.height)
                $0.width.equalTo(width ?? 0)
            }
        } else { // 사용자 정의 Width
            self.snp.makeConstraints {
                $0.height.equalTo(size.height)
                $0.width.equalTo(width ?? 0)
            }
        }
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
                bgColor = .clear
                bgPressedColor = HandySemantic.buttonBoxPrimaryDisabled
            } else {
                fgColor = HandySemantic.textBrandPrimary
                bgColor = .clear
                bgPressedColor = HandySemantic.buttonTextPrimaryPressed
            }

        case .secondary:
            borderColor = nil
            borderPressedColor = nil
            borderWidth = 0

            if isDisabled {
                fgColor = HandySemantic.textBasicDisabled
                bgColor = .clear
                bgPressedColor = HandySemantic.buttonBoxPrimaryDisabled
            } else {
                fgColor = HandySemantic.textBasicTertiary
                bgColor = .clear
                bgPressedColor = HandySemantic.buttonTextSecondaryPressed
            }
        }

        self.configurationUpdateHandler = { button in
            switch button.state {
            case .highlighted:
                self.buttonConfiguration.background.backgroundColor = self.bgPressedColor
            default:
                self.buttonConfiguration.baseForegroundColor = self.fgColor
                self.buttonConfiguration.background.backgroundColor = self.bgColor
            }
            button.configuration = self.buttonConfiguration
        }

        self.configuration = buttonConfiguration
        self.layer.borderWidth = borderWidth

        setBorderColorBasedOnIsHighlighted()
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
        self.layer.cornerRadius = CGFloat(size.rounding)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        isEnabled = !isDisabled
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        setBoxButtonColor()

        if !isIconSetup {
            setButtonLabel()
            setBoxButtonRounding()
            setButtonIcon()
            setBoxButtonSize()
            isIconSetup = true
        }
    }
}
