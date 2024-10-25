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
    @Invalidating(wrappedValue: "", .layout) public var text: String {
        didSet {
            label.text = text
        }
    }

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
        imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        imageView.tintColor = HandySemantic.bgStatusNegative
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
        setLabel()
        setBGView()

        showSnackbar()
    }

    private func setViewHierarchy() {
        self.addSubview(label)
    }

    private func setAutoLayout() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.width.equalTo(311)
        }
    }

    private func setLabel() {
        label.textColor = snackbarType.textColor
        label.text = text
        label.style = snackbarType.font

        if snackbarType == .error {
            // 경고 아이콘
            print(" === error === ")
        }
    }

    private func setBGView() {
        self.backgroundColor = snackbarType.bgColor
        self.layer.cornerRadius = 8
    }

    private func showSnackbar() {
        print("== showSnackbar ==")
        UIView.animate(
            withDuration: 0.5,
            delay: 0.0,
            options: .curveEaseInOut,
            animations: {
                self.alpha = 1.0
            }, completion: { _ in
                self.hideSnackbar()
            })
    }

    private func hideSnackbar() {
        UIView.animate(
            withDuration: 2.0,
            delay: 5.0,
            options: .curveEaseOut,
            animations: {
                self.alpha = 0.0
            }, completion: { _ in
                self.removeFromSuperview()
            })
    }

    override public func setNeedsLayout() {
        setLabel()
        setBGView()
    }
}
