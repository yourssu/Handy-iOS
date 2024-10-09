//
//  HansySwitchViewController.swift
//  Handy-Storybook
//
//  Created by 이조은 on 9/18/24.
//

import Handy
import UIKit

final class HansySwitchViewController: BaseViewController {

    let switch1: HandySwitch = {
        let uiSwitch = HandySwitch()
        uiSwitch.size = .large
        return uiSwitch
    }()

    let switch2: HandySwitch = {
        let uiSwitch = HandySwitch()
        uiSwitch.size = .medium
        uiSwitch.isOn = true
        return uiSwitch
    }()

    let switch3: HandySwitch = {
        let uiSwitch = HandySwitch()
        uiSwitch.size = .small
        uiSwitch.isDisabled = true
        return uiSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

    override func setViewHierarchies() {
        self.view.addSubview(switch1)
        self.view.addSubview(switch2)
        self.view.addSubview(switch3)
    }

    override func setViewLayouts() {
        switch1.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(20)
        }
        switch2.snp.makeConstraints {
            $0.top.equalTo(switch1.snp.bottom).offset(36) // -4
            $0.leading.equalToSuperview().inset(13) // -7
        }
        switch3.snp.makeConstraints {
            $0.top.equalTo(switch2.snp.bottom).offset(28) // -12
            $0.leading.equalToSuperview().inset(8) // -12
        }
    }
}
