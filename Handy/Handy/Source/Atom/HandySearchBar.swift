//
//  HandySearchBar.swift
//  Handy
//
//  Created by 성현주 on 1/1/25.
//

import UIKit
import SnapKit

final public class HandySearchBar: UIView {

    // MARK: - Properties

    /**
     왼쪽 버튼의 활성화 여부를 설정합니다.
     */
    @Invalidating(wrappedValue: true, .layout) public var leftIcon: Bool {
        didSet {
            leftButton.isHidden = !leftIcon
        }
    }

    /**
     오른쪽 버튼의 활성화 여부를 설정합니다.
     */
    @Invalidating(wrappedValue: true, .layout) public var rightIcon: Bool {
        didSet {
            rightButton.isHidden = !rightIcon
        }
    }

    /**
     텍스트 필드의 플레이스홀더를 설정합니다.
     */
    @Invalidating(wrappedValue: "", .layout) public var placeholder: String {
        didSet {
            textField.placeholder = placeholder
        }
    }

    private let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(HandyIcon.arrowsChevronLeftFilled.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = HandySemantic.iconBasicSecondary
        return button
    }()

    private let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(HandyIcon.filterBarFilled.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = HandySemantic.iconBasicSecondary
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
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = HandySemantic.bgBasicLight
        textField.layer.cornerRadius = HandySemantic.radiusM
        textField.leftViewMode = .always
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
        // searchIconImageView를 textField의 leftView로 설정
        let leftViewContainer = UIView()
        leftViewContainer.addSubview(searchIconImageView)
        searchIconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20) // 검색 아이콘 크기
        }
        leftViewContainer.snp.makeConstraints { make in
            make.width.height.equalTo(40) // 여백 포함 크기
        }
        textField.leftView = leftViewContainer

        // 스택뷰에 서브뷰 추가
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(rightButton)
        addSubview(stackView)

        // 기본 레이아웃 설정
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8) // 내부 여백
        }

        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(24) // 왼쪽 버튼 크기
        }

        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(24) // 오른쪽 버튼 크기
        }

        textField.snp.makeConstraints { make in
            make.height.equalTo(48) // 텍스트 필드 높이
        }
    }
}
