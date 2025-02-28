//
//  HandyListViewController.swift
//  Handy-Storybook
//
//  Created by 이조은 on 11/18/24.
//

import Handy

final class HandyListViewController: BaseViewController {

    private var list: HandyList = HandyList()

    private var listItem1: HandyListItem = {
        let listItem = HandyListItem()
        listItem.title = "마이페이지"
        listItem.leadingIcon = .icUserLine
        listItem.trailingIcon = .icArrowsChevronRightLine
        return listItem
    }()

    private var listItem2: HandyListItem = {
        let listItem = HandyListItem()
        listItem.title = "아이디 변경"
        listItem.leadingIcon = .icUserLine
        return listItem
    }()

    private var listItem3: HandyListItem = {
        let listItem = HandyListItem()
        listItem.title = "비밀번호 변경"
        listItem.trailingIcon = .icArrowsChevronRightLine
        return listItem
    }()

    private var listItem4: HandyListItem = {
        let listItem = HandyListItem()
        listItem.title = "이용약관"
        listItem.listState = .disabled
        return listItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewHierarchies() {
        list.addArrangedSubview(listItem1, listItem2, listItem3, listItem4)

        self.view.addSubview(list)

    }

    override func setViewLayouts() {
        list.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
    }
}
