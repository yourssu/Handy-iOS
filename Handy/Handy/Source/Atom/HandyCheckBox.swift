//
//  HandyCheckBox.swift
//  Handy
//
//  Created by 성현주 on 7/21/24.
//

import UIKit

public class HandyCheckBox: UIButton {

    // MARK: - 외부에서 지정할 수 있는 속성

    /**
     체크박스를 비활성화 시킬 때 사용합니다.
     */
    @Invalidating(.layout, .display) public var isDisabled: Bool = false {
        didSet {
            setConfiguration()
        }
    }

    /**
     체크박스의 선택 여부를 나타낼 때 사용합니다.
     */
    public override var isSelected: Bool {
        didSet { setConfiguration() }
    }

    /**
     타이포 크기, 아이콘 크기, 아이콘과 라벨 사이 간격을 결정할 때 사용합니다.
     */
    @Invalidating(.layout, .display) public var size: CheckboxSize = .large {
        didSet {
            setConfiguration()
        }
    }

    /**
     체크박스의 글귀를 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: nil, .layout) public var text: String? {
        didSet {
            setConfiguration()
        }
    }

    /**
     체크박스의 tintColor를 설정할 때 사용합니다.
     */
    public var setTintColor: UIColor = HandySemantic.checkboxSelected {
        didSet {
            setConfiguration()
        }
    }

    // MARK: - 외부에서 접근할 수 있는 enum

    /**
     체크박스의 size 종류입니다.
     각 size에 맞는 font, iconSize, spacing을 computed property로 가지고 있습니다.
     */
    public enum CheckboxSize {
        case small
        case medium
        case large

        fileprivate var iconSize: CGFloat {
            switch self {
            case .small:
                return 16
            case .medium:
                return 20
            case .large:
                return 24
            }
        }

        fileprivate var font: UIFont {
            switch self {
            case .small:
                return HandyFont.B5Rg12
            case .medium:
                return HandyFont.B3Rg14
            case .large:
                return HandyFont.B1Rg16
            }
        }
    }

    // MARK: - 메소드

    public init() {
        super.init(frame: .zero)
        setConfiguration()
        registerTapAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConfiguration() {
        var configuration = UIButton.Configuration.plain()
        configuration.baseBackgroundColor = .clear
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        self.configuration = configuration

        setTitle()
        setImage()
        setColor()
        updateState()
    }

    private func setTitle() {
        guard var configuration = self.configuration else { return }
        configuration.attributedTitle = AttributedString(text ?? "")
        configuration.attributedTitle?.font = size.font
        self.configuration = configuration
    }

    private func setImage() {
        guard var configuration = self.configuration else { return }

        configuration.imagePadding = 8
        configuration.imagePlacement = .leading

        let image: UIImage
        if isDisabled || isSelected {
            image = HandyIcon.checkBoxFilled
        } else {
            image = HandyIcon.checkBoxLine
        }
        configuration.image = image.resize(to: size.iconSize)

        self.configuration = configuration
    }


    private func setColor() {
        guard var configuration = self.configuration else { return }

        if isSelected {
            configuration.image = configuration.image?.withTintColor(setTintColor)
        }


        self.configuration = configuration
    }


    private func updateState() {
        guard var configuration = self.configuration else { return }

        configuration.baseForegroundColor = HandySemantic.textBasicPrimary
        self.isEnabled = !isDisabled

        self.configuration = configuration
    }


    private func registerTapAction() {
        self.addTarget(self,
                       action: #selector(checkboxDidTap(_:)),
                       for: .touchUpInside
        )
    }

    @objc
    private func checkboxDidTap(_ sender: UIControl) {
        self.isSelected = !isSelected
    }
}
