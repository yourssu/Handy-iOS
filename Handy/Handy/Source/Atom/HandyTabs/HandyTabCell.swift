//
//  HandyTabCell.swift
//  Handy
//
//  Created by chongin on 12/31/24.
//

import UIKit

/// ``HandyTabs``의 Header를 구성하는 cell입니다.
open class HandyTabCell: UICollectionViewCell {
    // MARK: - open & public properties

    /// 글씨 크기를 결정합니다.
    open var sizeType: SizeType = .large {
        didSet {
            setConfiguration()
        }
    }
    
    /// 해당 탭을 대표할 이름입니다.
    open var title: String = "Tab" {
        didSet {
            setTitleLabel()
        }
    }

    /// 현재 탭이 선택되었는지를 나타내는 변수입니다.
    open override var isSelected: Bool {
        didSet {
            if oldValue == isSelected { return }
            setConfiguration()
        }
    }

    // MARK: - internal & private properties

    /// title이 표시될 label입니다.
    internal let titleLabel: HandyLabel = {
        let label = HandyLabel(style: .B1Sb16)
        label.alignment = .center
        return label
    }()

    /// 현재 선택됨을 알려주는, 아래쪽에 표시되는 검은색 바입니다.
    internal let selectedIndicator = UIView()

    // MARK: - init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViewHierarchy()
        initializeConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - private methods

    private func initializeViewHierarchy() {
        // Set View Hierarchy
        self.addSubview(titleLabel)
        self.addSubview(selectedIndicator)
    }

    private func initializeConstraints() {
        // Set Constraints
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16).priority(999)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(48)
        }

        selectedIndicator.snp.makeConstraints {
            $0.bottom.equalToSuperview().priority(999)
            $0.leading.trailing.equalToSuperview().inset(18).priority(999)
            $0.height.equalTo(2)
        }
    }

    private func setConfiguration() {
        setTitleLabel()
        setIndicatorBar()
    }

    private func setTitleLabel() {
        titleLabel.text = title
        titleLabel.style = switch sizeType {
        case .small:
            String.HandyTypoStyle.B3Sb14
        case .large:
            String.HandyTypoStyle.B1Sb16
        }
        titleLabel.textColor = switch isSelected {
        case true: HandySemantic.textBasicPrimary
        case false: HandySemantic.textBasicTertiary
        }
    }

    private func setIndicatorBar() {
        selectedIndicator.backgroundColor = HandySemantic.bgBasicBlack
        selectedIndicator.layer.cornerRadius = 1
        selectedIndicator.isHidden = !isSelected
    }
}

extension HandyTabCell {
    public enum SizeType {
        case small
        case large
    }
}

extension HandyTabCell {
    static let reuseIdentifier = "HandyTabCell"
}
