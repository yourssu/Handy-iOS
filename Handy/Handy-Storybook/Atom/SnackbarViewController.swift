//
//  SnackbarViewController.swift
//  Handy
//
//  Created by 이조은 on 10/25/24.
//

import Handy

final class SnackbarViewController: BaseViewController {

    let snackbar1: HandySnackbar = {
        let snackbar = HandySnackbar()
        snackbar.text =  "정보성 메세지가 들어갑니다. 최대 2줄 입력 가능합니다."
        return snackbar
    }()

    let snackbar2: HandySnackbar = {
        let snackbar = HandySnackbar()
        snackbar.text =  "이것은 줄 수가 두 줄이 되는 스낵바 메시지 예시입니다.좌측 정렬을 해주세요."
        return snackbar
    }()

    let snackbar3: HandySnackbar = {
        let snackbar = HandySnackbar()
        snackbar.text =  "에러 메세지가 들어갑니다"
        snackbar.snackbarType = .error
        return snackbar
    }()

    let snackbar4: HandySnackbar = {
        let snackbar = HandySnackbar()
        snackbar.text =  "이렇게 두 줄의 에러 메세지가 들어가야할 경우 아이콘은 모두 위로 정렬해주세요."
        snackbar.snackbarType = .error
        return snackbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setViewHierarchies() {
        self.view.addSubview(snackbar1)
//        self.view.addSubview(snackbar2)
//        self.view.addSubview(snackbar3)
        self.view.addSubview(snackbar4)
    }

    override func setViewLayouts() {
        snackbar1.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(56)
            $0.centerX.equalToSuperview()
        }
//        snackbar2.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(156)
//            $0.centerX.equalToSuperview()
//        }
//        snackbar3.snp.makeConstraints {
//            $0.bottom.equalToSuperview().inset(256)
//            $0.centerX.equalToSuperview()
//        }
        snackbar4.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(356)
            $0.centerX.equalToSuperview()
        }
    }
}

