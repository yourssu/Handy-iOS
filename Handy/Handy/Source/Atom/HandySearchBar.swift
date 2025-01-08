//
//  HandySearchBar.swift
//  Handy
//
//  Created by 성현주 on 1/1/25.
//

import UIKit
import SnapKit

public class HandySearchBar: UIView {

    // MARK: - 외부에서 설정할 수 있는 속성

    /**
     왼쪽 버튼의 활성화 여부를 설정합니다.
     */
    public var leftIcon: Bool = true {
        didSet {
            leftButton.isHidden = !leftIcon
        }
    }

    /**
     오른쪽 버튼의 활성화 여부를 설정합니다.
     */
    public var rightIcon: Bool = true {
        didSet {
            rightButton.isHidden = !rightIcon
        }
    }

    /**
     텍스트 필드의 플레이스홀더를 설정합니다.
     */
    public var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }

    // MARK: - Properties

    public let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(HandyIcon.arrowsChevronLeftFilled.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = HandySemantic.iconBasicSecondary
        return button
    }()

    public let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(HandyIcon.filterBarFilled.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = HandySemantic.iconBasicSecondary
        return button
    }()

    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(HandyIcon.cancelFilled, for: .normal)
        button.tintColor = HandySemantic.iconBasicTertiary
        button.isHidden = true
        return button
    }()

    private let searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = HandyIcon.searchLine.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = HandySemantic.iconBasicTertiary
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Text input"
        textField.font = HandyFont.B1Rg16
        textField.textColor = HandySemantic.textBasicPrimary
        textField.borderStyle = .none
        textField.backgroundColor = HandySemantic.bgBasicLight
        textField.layer.cornerRadius = HandySemantic.radiusM
        textField.leftViewMode = .always
        textField.rightViewMode = .whileEditing
        return textField
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        setupLeftView()
        setupRightView()

        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(rightButton)
        addSubview(stackView)

        // 기본 레이아웃 설정
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        leftButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }

        rightButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }

        textField.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }

    /**
     텍스트 필드의 왼쪽에 표시되는 아이콘 뷰를 설정합니다.
     */
    private func setupLeftView() {
        let leftViewContainer = UIView()
        leftViewContainer.addSubview(searchIconImageView)
        searchIconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        leftViewContainer.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        textField.leftView = leftViewContainer
    }

    /**
     텍스트 필드의 오른쪽에 표시되는 clearButton 뷰를 설정합니다.
     */
    private func setupRightView() {
        let rightViewContainer = UIView()
        rightViewContainer.addSubview(clearButton)
        clearButton.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        rightViewContainer.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        textField.rightView = rightViewContainer
    }
}

private extension HandySearchBar {
    /**
     텍스트 필드의 내용을 지우고, clearButton을 숨깁니다.
     */
    @objc func clearText() {
        textField.text = ""
        clearButton.isHidden = true
    }

    /**
     텍스트 필드의 내용이 변경될 때 clearButton의 표시 여부를 업데이트합니다.
     */
    @objc func textDidChange() {
        clearButton.isHidden = textField.text?.isEmpty ?? true
    }
}
