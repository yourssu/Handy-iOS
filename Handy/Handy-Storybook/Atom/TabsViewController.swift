//
//  TabsViewController.swift
//  Handy
//
//  Created by chongin on 12/29/24.
//

import Handy

final class TabsViewController: BaseViewController {
    private let tab1: HandyTabComponent = {
        let tabComponent = HandyTabComponent(size: .small)
        tabComponent.backgroundColor = .gray100
        tabComponent.title = "tabbbbb"
        return tabComponent
    }()

    private let tab2: HandyTabComponent = {
        let tabComponent = HandyTabComponent(size: .large)
        tabComponent.backgroundColor = .gray100
        tabComponent.title = "tabbbbb"
        tabComponent.isSelected = true
        return tabComponent
    }()

    override func setViewHierarchies() {
        self.view.addSubview(tab1)
        self.view.addSubview(tab2)
    }

    override func setViewLayouts() {
        tab1.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(100)
        }

        tab2.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(200)
        }
    }
}


import UIKit

open class HandyTabComponent: UIControl {
    public var size: SizeType = .large

    private let titleLabel = HandyLabel(style: .B1Sb16)
    private let activeIndicatorBar = UIView()

    public var title: String? {
        didSet {
            setTitleLabel()
        }
    }

    public override var isSelected: Bool {
        didSet {
            setConfiguration()
        }
    }

    public init(size: SizeType) {
        super.init(frame: .zero)
        self.size = size
        initializeViewHierarchy()
        initializeConstraints()
        setConfiguration()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeViewHierarchy() {
        // Set View Hierarchy
        self.addSubview(titleLabel)
        self.addSubview(activeIndicatorBar)
    }

    private func initializeConstraints() {
        // Set Constraints
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
        }

        activeIndicatorBar.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(18)
            $0.height.equalTo(2)
        }
    }

    private func setConfiguration() {
        setTitleLabel()
        setIndicatorBar()
    }

    private func setTitleLabel() {
        titleLabel.text = title
        titleLabel.style = switch size {
        case .small:
            String.HandyTypoStyle.B3Sb14
        case .large:
            String.HandyTypoStyle.B1Sb16
        }
    }

    private func setIndicatorBar() {
        activeIndicatorBar.backgroundColor = HandySemantic.bgBasicBlack
        activeIndicatorBar.layer.cornerRadius = 1
        activeIndicatorBar.isHidden = !isSelected
    }
}

extension HandyTabComponent {
    public enum SizeType {
        case small
        case large
    }
}
