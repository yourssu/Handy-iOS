//
//  FabViewController.swift
//  Handy-Storybook
//
//  Created by 정민지 on 7/31/24.
//

import Handy

final class FabViewController: BaseViewController {

    let primaryFab: HandyFab = {
        let checkBox = HandyFab()
        return checkBox
    }()

    let disabledPrimaryFab: HandyFab = {
        let checkBox = HandyFab()
        checkBox.isDisabled = true
        return checkBox
    }()
    
    let secondaryFab: HandyFab = {
        let checkBox = HandyFab()
        checkBox.type = .secondary
        checkBox.size = .small
        return checkBox
    }()

    let disabledSecondaryFab: HandyFab = {
        let checkBox = HandyFab()
        checkBox.type = .secondary
        checkBox.size = .small
        checkBox.isDisabled = true
        return checkBox
    }()
    
    let customIconFab: HandyFab = {
        let checkBox = HandyFab()
        checkBox.size = .small
        checkBox.iconImage = .add
        return checkBox
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewHierarchies() {
        [
            primaryFab,
            disabledPrimaryFab,
            secondaryFab,
            disabledSecondaryFab,
            customIconFab
        ].forEach {
            view.addSubview($0)
        }
    }

    override func setViewLayouts() {
        primaryFab.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        disabledPrimaryFab.snp.makeConstraints {
            $0.top.equalTo(primaryFab.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        secondaryFab.snp.makeConstraints {
            $0.top.equalTo(disabledPrimaryFab.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        disabledSecondaryFab.snp.makeConstraints {
            $0.top.equalTo(secondaryFab.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        customIconFab.snp.makeConstraints {
            $0.top.equalTo(disabledSecondaryFab.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

