//
//  HandySnackbar.swift
//  Handy
//
//  Created by 이조은 on 10/23/24.
//

import UIKit
import SnapKit

final public class HandySnackbar: UIView {

    /**
     스낵바에 들어갈 글을 설정할 때 사용합니다.
     */
    @Invalidating(wrappedValue: "", .layout) public var text: String

    /**
     스낵바의 외관 타입을 결정할 때 사용합니다.
     */
    @Invalidating(.display) public var snackbarType: SnackbarType = .info

    public enum SnackbarType {
        case info
        case error

        fileprivate var bgColor: UIColor {
            switch self {
            case .info:
                return .gray800
            case .error:
                return .redSub
            }
        }

        fileprivate var textColor: UIColor {
            switch self {
            case .info:
                return HandySemantic.textBasicWhite
            case .error:
                return HandySemantic.textStatusNegative
            }
        }

        fileprivate var font: String.HandyTypoStyle {
            switch self {
            case .info:
                return .B3Rg14
            case .error:
                return .B3Sb14
            }

        }
    }

    private let label: HandyLabel = {
        let label = HandyLabel()
        label.alignment = .left
        label.numberOfLines = 2
        return label
    }()

    private let errorIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = HandyIcon.alertTriangleFilled.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = HandySemantic.bgStatusNegative
        return imageView
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(HandyIcon.closeLine.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = HandySemantic.iconBasicTertiary
        button.addTarget(self, action: #selector(nowHideSnackbar), for: .touchUpInside)
        return button
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
        setLabel()
        setBGView()

        showSnackbar()
        setSwipeGesture()
    }

    private func setViewHierarchy() {
        self.addSubview(label)
        self.addSubview(errorIcon)
        self.addSubview(cancelButton)
    }

    private func setAutoLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(328)
        }
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(296)
            $0.height.greaterThanOrEqualTo(20)
        }
        errorIcon.snp.makeConstraints {
            $0.size.equalTo(20)
            $0.top.leading.equalToSuperview().inset(16)
        }
        cancelButton.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.top.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(16)
        }
    }

    private func setBGView() {
        self.backgroundColor = snackbarType.bgColor
        self.layer.cornerRadius = HandySemantic.radiusM
    }

    private func setLabel() {
        label.textColor = snackbarType.textColor
        label.text = text
        label.style = snackbarType.font
    }

    private func setIcon() {
        if snackbarType == .error {

            errorIcon.isHidden = false
            cancelButton.isHidden = false

            label.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(44)
                $0.width.equalTo(240)
            }

        } else {
            errorIcon.isHidden = true
            cancelButton.isHidden = true

            label.snp.updateConstraints {
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.width.equalTo(296)
            }
        }
    }

    private func setSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGesture.direction = .down

        self.addGestureRecognizer(swipeGesture)
    }

    private func showSnackbar() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: {
                self.alpha = 1.0
            }, completion: { _ in
                if self.snackbarType == .info {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        if self.alpha != 0.0 {
                            self.hideSnackbar()
                        }
                    }
               }
            })
    }

    private func hideSnackbar() {
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .curveEaseOut,
            animations: {
                self.alpha = 0.0
            }, completion: { _ in
                self.removeFromSuperview()
            })
    }

    @objc
    private func nowHideSnackbar() {
        hideSnackbar()
    }

    @objc
    private func handleSwipeGesture(_ gestureRecognizer: UISwipeGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            hideSnackbar()
        }
    }

    override public func setNeedsLayout() {
        setBGView()
        setLabel()
        setIcon()
    }
}
