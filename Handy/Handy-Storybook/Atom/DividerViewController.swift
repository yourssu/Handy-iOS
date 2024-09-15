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
    // horizontal Divider
    let divider1: HandyDivider = {
        let divider = HandyDivider(.horizontal)
        divider.thickness = .thickness4
        return divider
    }()
    
    let divider2: HandyDivider = {
        let divider = HandyDivider(.horizontal)
        divider.thickness = .thickness2
        return divider
    }()
    
    let divider4: HandyDivider = {
        let divider = HandyDivider(.horizontal)
        divider.thickness = .thickness4
        return divider
    }()
    
    let divider8: HandyDivider = {
        let divider = HandyDivider(.horizontal)
        divider.thickness = .thickness8
        return divider
    }()
    
    // vertical Divider
    let vContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let vDivider1: HandyDivider = {
        let divider = HandyDivider(.vertical)
        divider.thickness = .thickness1
        return divider
    }()
    
    let vDivider2: HandyDivider = {
        let divider = HandyDivider(.vertical)
        divider.thickness = .thickness2
        return divider
    }()
    
    let vDivider4: HandyDivider = {
        let divider = HandyDivider(.vertical)
        divider.thickness = .thickness4
        return divider
    }()
    
    let vDivider8: HandyDivider = {
        let divider = HandyDivider(.vertical)
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
        
        self.view.addSubview(vDivider1)
        self.view.addSubview(vDivider2)
        self.view.addSubview(vDivider4)
        self.view.addSubview(vDivider8)
    }
    
    //MARK: - 레이아웃 배치
    override func setViewLayouts() {
        /// horizontal Divider Layout
        divider1.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.snp.top).offset(150)
        }
        
        
        divider2.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divider1.snp.bottom).offset(20)
        }
        
        divider4.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divider2.snp.bottom).offset(20)
        }
        
        divider8.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.width.equalTo(375)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(divider4.snp.bottom).offset(20)
        }
        
        /// vertical Divider Layout
        vDivider1.snp.makeConstraints {
            $0.height.equalTo(375)
            $0.width.equalTo(0)
            $0.leading.equalToSuperview().offset(155)
            $0.top.equalTo(divider1.snp.bottom).offset(200)
        }
        
        vDivider2.snp.makeConstraints {
            $0.height.equalTo(375)
            $0.width.equalTo(0)
            $0.centerY.equalTo(vDivider1.snp.centerY)
            $0.leading.equalTo(vDivider1.snp.trailing).offset(20)
        }
        
        vDivider4.snp.makeConstraints {
            $0.height.equalTo(375)
            $0.width.equalTo(0)
            $0.centerY.equalTo(vDivider1.snp.centerY)
            $0.leading.equalTo(vDivider2.snp.trailing).offset(20)
        }
        
        vDivider8.snp.makeConstraints {
            $0.height.equalTo(375)
            $0.width.equalTo(0)
            $0.centerY.equalTo(vDivider1.snp.centerY)
            $0.leading.equalTo(vDivider4.snp.trailing).offset(20)
        }
    }
}
