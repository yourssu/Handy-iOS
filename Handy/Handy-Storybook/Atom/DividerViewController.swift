//
//  DividerViewController.swift
//  Handy-Storybook
//
//  Created by 서준영 on 9/15/24.
//

import Handy
import UIKit
import SnapKit

class DividerViewController: BaseViewController {
    
    //MARK: - 프로퍼티 선언
    let divider1: HandyDivider = {
        let divider = HandyDivider()
        divider.thickness = .thickness1
        return divider
    }()
    
    let divider2: HandyDivider = {
        let divider = HandyDivider()
        divider.thickness = .thickness2
        return divider
    }()
    
    let divider4: HandyDivider = {
        let divider = HandyDivider()
        divider.thickness = .thickness4
        return divider
    }()
    
    let divider8: HandyDivider = {
        let divider = HandyDivider()
        divider.thickness = .thickness8
        return divider
    }()

    //MARK: - 뷰에 추가
    override func setViewHierarchies() {
        self.view.backgroundColor = .black
        self.view.addSubview(divider1)
        self.view.addSubview(divider2)
        self.view.addSubview(divider4)
        self.view.addSubview(divider8)
    }
    
    //MARK: - 레이아웃 배치
    override func setViewLayouts() {
        divider1.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.snp.top).offset(300)
        }
        
        divider2.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divider1.snp.bottom).offset(20)
        }
        
        divider4.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divider2.snp.bottom).offset(20)
        }
        
        divider8.snp.makeConstraints {
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divider4.snp.bottom).offset(20)
        }
    }
}
