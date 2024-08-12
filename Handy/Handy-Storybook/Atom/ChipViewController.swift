//
//  ChipViewController.swift
//  Handy-Storybook
//
//  Created by 서준영 on 7/29/24.
//

import UIKit
import Handy
import SnapKit

class ChipViewController: BaseViewController {
    
    //MARK: 프로퍼티 선언
    let unTappedLargeChip: HandyChip = {
        let chip = HandyChip()
        chip.chipState = HandyChip.ChipState(type: .enabled)
        chip.size = HandyChip.ChipSize(type: .large)
        chip.isSelected = false
        chip.text = "Label"
        chip.addTarget(self, action: #selector(firstChip), for: .touchUpInside)
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    let unTappedSmallChip: HandyChip = {
        let chip = HandyChip()
        chip.chipState = HandyChip.ChipState(type: .enabled)
        chip.size = HandyChip.ChipSize(type: .small)
        chip.isSelected = false
        chip.text = "Label"
        chip.addTarget(self, action: #selector(secondChip), for: .touchUpInside)
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    let tappedLargeChip: HandyChip = {
        let chip = HandyChip()
        chip.chipState = HandyChip.ChipState(type: .enabled)
        chip.size = HandyChip.ChipSize(type: .large)
        chip.isSelected = true
        chip.text = "Label"
        chip.addTarget(self, action: #selector(thirdChip), for: .touchUpInside)
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    let tappedSmallChip: HandyChip = {
        let chip = HandyChip()
        chip.chipState = HandyChip.ChipState(type: .enabled)
        chip.size = HandyChip.ChipSize(type: .small)
        chip.isSelected = true
        chip.text = "Label"
        chip.addTarget(self, action: #selector(fourthChip), for: .touchUpInside)
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    let disabledLargeChip: HandyChip = {
        let chip = HandyChip()
        chip.chipState = HandyChip.ChipState(type: .disabled)
        chip.size = HandyChip.ChipSize(type: .large)
        chip.text = "Label"
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    let disabledSmallChip: HandyChip = {
        let chip = HandyChip()
        chip.chipState = HandyChip.ChipState(type: .disabled)
        chip.size = HandyChip.ChipSize(type: .small)
        chip.text = "Label"
        chip.translatesAutoresizingMaskIntoConstraints = false
        return chip
    }()
    
    
    //MARK: Chip 뷰에 추가
    override func setViewHierarchies() {
        view.addSubview(unTappedLargeChip)
        view.addSubview(unTappedSmallChip)
        view.addSubview(tappedLargeChip)
        view.addSubview(tappedSmallChip)
        view.addSubview(disabledLargeChip)
        view.addSubview(disabledSmallChip)
    }
    
    
    //MARK: 레이아웃 배치
    override func setViewLayouts() {
        unTappedLargeChip.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
        }
        unTappedSmallChip.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(unTappedLargeChip.snp.bottom).offset(24)
        }
        tappedLargeChip.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(unTappedSmallChip.snp.bottom).offset(51)
        }
        tappedSmallChip.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tappedLargeChip.snp.bottom).offset(24)
        }
        disabledLargeChip.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tappedSmallChip.snp.bottom).offset(51)
        }
        disabledSmallChip.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(disabledLargeChip.snp.bottom).offset(24)
        }
    }
    
    
    //MARK: Chip 작동 함수
    @objc private func firstChip(_ sender: HandyChip) {
        sender.isSelected.toggle()
    }
    @objc private func secondChip(_ sender: HandyChip) {
        sender.isSelected.toggle()
    }
    @objc private func thirdChip(_ sender: HandyChip) {
        sender.isSelected.toggle()
    }
    @objc private func fourthChip(_ sender: HandyChip) {
        sender.isSelected.toggle()
    }
}
