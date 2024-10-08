//
//  LabelViewController.swift
//  Handy-Storybook
//
//  Created by 이조은 on 7/22/24.
//

import Handy

final class LabelViewController: BaseViewController {

    let D1Sb56Label: HandyLabel = {
        let label = HandyLabel(style: .D1Sb56)
        label.text =  "Handy \nHello, World!"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let H1Rg32Label: HandyLabel = {
        let label = HandyLabel(style: .H1Rg32)
        label.text =  "Handy \nHello, World!"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let T2Lt18Label: HandyLabel = {
        let label = HandyLabel(style: .T2Lt18)
        label.text =  "Handy \nHello, World!"
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewHierarchies() {
        self.view.addSubview(D1Sb56Label)
        self.view.addSubview(H1Rg32Label)
        self.view.addSubview(T2Lt18Label)
    }

    override func setViewLayouts() {
        D1Sb56Label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(20)
        }
        H1Rg32Label.snp.makeConstraints {
            $0.top.equalTo(D1Sb56Label.snp.bottom).offset(100)
            $0.leading.equalToSuperview().inset(20)
        }
        T2Lt18Label.snp.makeConstraints {
            $0.top.equalTo(H1Rg32Label.snp.bottom).offset(100)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}

