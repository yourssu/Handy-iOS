//
//  HandyBoxButtonViewController.swift
//  Handy-Storybook
//
//  Created by 이조은 on 7/29/24.
//

import Handy
import UIKit

final class HandyBoxButtonViewController: BaseViewController {

    let boxButton1: HandyBoxButton = {
        let button = HandyBoxButton()
        button.text = "Button"
        button.type = .primary
        button.size = .xLarge
        button.leftIcon = UIImage(named:"testIcon")
        button.rightIcon = UIImage(named:"testIcon")
        return button
    }()

    let boxButton2: HandyBoxButton = {
        let button = HandyBoxButton()
        button.text = "Button"
        button.type = .secondary
        button.size = .large
        button.rightIcon = UIImage(named:"testIcon")
        return button
    }()

    let boxButton3: HandyBoxButton = {
        let button = HandyBoxButton()
        button.text = "Button"
        button.type = .tertiary
        button.size = .medium
        button.leftIcon = UIImage(named:"testIcon")
        return button
    }()

    let boxButton4: HandyBoxButton = {
        let button = HandyBoxButton()
        button.text = "Button"
        button.type = .tertiary
        button.size = .xSmall
        button.leftIcon = UIImage(named:"testIcon")
        button.rightIcon = UIImage(named:"testIcon")
        button.isDisabled = true
        return button
    }()

    let boxButton6: HandyBoxButton = {
        let button = HandyBoxButton()
        button.text = "Button"
        button.type = .tertiary
        button.size = .xSmall
        return button
    }()

    let boxButton7: HandyBoxButton = {
        let button = HandyBoxButton()
        button.text = "Button"
        button.type = .primary
        button.size = .xxSmall
        button.leftIcon = UIImage(named:"testIcon")
        return button
    }()

    let boxButton5: HandyBoxButton = {
        let button = HandyBoxButton()
        button.text = "Next"
        button.type = .primary
        button.size = .large
        button.width = 330
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

    override func setViewHierarchies() {
        self.view.addSubview(boxButton1)
        self.view.addSubview(boxButton2)
        self.view.addSubview(boxButton3)
        self.view.addSubview(boxButton4)
        self.view.addSubview(boxButton5)
        self.view.addSubview(boxButton6)
        self.view.addSubview(boxButton7)
    }

    override func setViewLayouts() {
        boxButton1.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(20)
        }
        boxButton2.snp.makeConstraints {
            $0.top.equalTo(boxButton1.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        boxButton3.snp.makeConstraints {
            $0.top.equalTo(boxButton2.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        boxButton4.snp.makeConstraints {
            $0.top.equalTo(boxButton3.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        boxButton6.snp.makeConstraints {
            $0.top.equalTo(boxButton4.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        boxButton7.snp.makeConstraints {
            $0.top.equalTo(boxButton6.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        boxButton5.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
    }
}


