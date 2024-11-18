//
//  HandyListItem.swift
//  Handy
//
//  Created by 이조은 on 11/9/24.
//

import UIKit

import SnapKit

final public class HandyListItem: UIView {

    // MARK: - 외부에서 지정할 수 있는 속성

    /**
     Title의 text를 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: "", .layout) public var title: String {
        didSet {
            titleLabel.text = title
        }
    }

    /**
     Leading icon 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: nil, .layout) public var leadingIcon: UIImage?

    /**
     Trailing icon 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: nil, .layout) public var trailingIcon: UIImage?

    /**
     List의 상태를 설정할 때 사용합니다.
     */
    @Invalidating(.display) public var listState: ListState = .enabled

    private var isPressed: Bool = false

    private var tapGesture: UILongPressGestureRecognizer?

    public enum ListState {
        case enabled
        case disabled

        fileprivate var bgColor: UIColor {
            switch self {
            case .enabled:
                return HandySemantic.listEnabled
            case .disabled:
                return HandySemantic.listDisabled
            }
        }

        fileprivate var fgColor: UIColor {
            switch self {
            case .enabled:
                return HandySemantic.textBasicPrimary
            case .disabled:
                return HandySemantic.textBasicDisabled
            }
        }
    }

    private var titleLabel: HandyLabel = {
        let label = HandyLabel()
        label.style = .B1Rg16
        label.textColor = HandySemantic.textBasicPrimary
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private var leftIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = HandySemantic.iconBasicPrimary
        return imageView
    }()

    private var rightIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = HandySemantic.iconBasicPrimary
        return imageView
    }()

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
        setViewHierarchy()
        setAutoLayout()

        setIcon()
        setLabel()
    }

    private func setViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(leftIcon)
        self.addSubview(rightIcon)
    }

    private func setAutoLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.height.equalTo(64)
        }

        if leadingIcon == nil {
            leftIcon.isHidden = true

            titleLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
        } else {
            leftIcon.isHidden = false

            leftIcon.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(16)
                $0.size.equalTo(24)
                $0.centerY.equalToSuperview()
            }

            titleLabel.snp.remakeConstraints {
                $0.leading.equalTo(leftIcon.snp.trailing).offset(16)
                $0.centerY.equalToSuperview()
            }
        }

        if trailingIcon == nil {
            rightIcon.isHidden = true
        } else {
            rightIcon.isHidden = false

            rightIcon.snp.makeConstraints {
                $0.trailing.equalToSuperview().inset(16)
                $0.size.equalTo(24)
                $0.centerY.equalToSuperview()
            }
        }
    }

    private func setIcon() {
        leftIcon.image = leadingIcon?.withRenderingMode(.alwaysTemplate)
        leftIcon.tintColor = listState.fgColor
        rightIcon.image = trailingIcon?.withRenderingMode(.alwaysTemplate)
        rightIcon.tintColor = listState.fgColor
    }

    private func setLabel() {
        titleLabel.text = title
        titleLabel.textColor = listState.fgColor

        self.backgroundColor = listState.bgColor
    }

    private func setupGestureRecognizer() {
        if listState == ListState.enabled {
            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(pressedAction(_:)))
            self.tapGesture = gesture
            self.tapGesture?.minimumPressDuration = 0
            if let tapGesture = self.tapGesture {
                self.addGestureRecognizer(tapGesture)
            }
            self.isUserInteractionEnabled = true
        }
    }

    @objc public func pressedAction(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            self.backgroundColor = HandySemantic.listPressed
        case .ended, .cancelled, .failed:
            self.backgroundColor = listState.bgColor
        default:
            break
        }
    }


    public override func setNeedsLayout() {
        setAutoLayout()

        setIcon()
        setLabel()
    }

    public override func setNeedsDisplay() {
        if let gesture = tapGesture {
            self.removeGestureRecognizer(gesture)
        }
        tapGesture = nil

        setupGestureRecognizer()
    }

}
