//
//  ChipViewController.swift
//  Handy-Storybook
//
//  Created by 서준영 on 7/29/24.
//

import UIKit
import Handy

class ChipViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
        Chip setup
         */
        // enabled 상태(기본), Large(기본), isSelected X
        let unTappedLargeChip = HandyChip()
        unTappedLargeChip.chipState = HandyChip.ChipState(type: .enabled)
        unTappedLargeChip.size = HandyChip.ChipSize(type: .large)
        unTappedLargeChip.isSelected = false
        unTappedLargeChip.text = "Label"
        unTappedLargeChip.addTarget(self, action: #selector(firstChip), for: .touchUpInside)
        unTappedLargeChip.translatesAutoresizingMaskIntoConstraints = false
        
        // enabled 상태(기본), Small, isSelected X
        let unTappedSmallChip = HandyChip()
        unTappedSmallChip.chipState = HandyChip.ChipState(type: .enabled)
        unTappedSmallChip.size = HandyChip.ChipSize(type: .small)
        unTappedSmallChip.isSelected = false
        unTappedSmallChip.text = "Label"
        unTappedSmallChip.addTarget(self, action: #selector(secondChip), for: .touchUpInside)
        unTappedSmallChip.translatesAutoresizingMaskIntoConstraints = false
        
        
        // enabled 상태(기본), Large(기본), isSelected O
        let tappedLargeChip = HandyChip()
        tappedLargeChip.chipState = HandyChip.ChipState(type: .enabled)
        tappedLargeChip.size = HandyChip.ChipSize(type: .large)
        tappedLargeChip.isSelected = true
        tappedLargeChip.text = "Label"
        tappedLargeChip.addTarget(self, action: #selector(thirdChip), for: .touchUpInside)
        tappedLargeChip.translatesAutoresizingMaskIntoConstraints = false
        
        // enabled 상태(기본), Small, isSelected X
        let tappedSmallChip = HandyChip()
        tappedSmallChip.chipState = HandyChip.ChipState(type: .enabled)
        tappedSmallChip.size = HandyChip.ChipSize(type: .small)
        tappedSmallChip.isSelected = true
        tappedSmallChip.text = "Label"
        tappedSmallChip.addTarget(self, action: #selector(fourthChip), for: .touchUpInside)
        tappedSmallChip.translatesAutoresizingMaskIntoConstraints = false
        
        
        // disabled 상태(기본), Large(기본)
        let disabledLargeChip = HandyChip()
        disabledLargeChip.chipState = HandyChip.ChipState(type: .disabled)
        disabledLargeChip.size = HandyChip.ChipSize(type: .large)
        disabledLargeChip.text = "Label"
        disabledLargeChip.translatesAutoresizingMaskIntoConstraints = false
        
        // disabled 상태(기본), Small
        let disabledSmallChip = HandyChip()
        disabledSmallChip.chipState = HandyChip.ChipState(type: .disabled)
        disabledSmallChip.size = HandyChip.ChipSize(type: .small)
        disabledSmallChip.text = "Label"
        disabledSmallChip.translatesAutoresizingMaskIntoConstraints = false
        
        /**
         Chip 뷰에 추가
         */
        view.addSubview(unTappedLargeChip)
        view.addSubview(unTappedSmallChip)
        
        view.addSubview(tappedLargeChip)
        view.addSubview(tappedSmallChip)
        
        view.addSubview(disabledLargeChip)
        view.addSubview(disabledSmallChip)
        
        /**
         Auto Layout 설정
         */
        NSLayoutConstraint.activate([
            unTappedLargeChip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unTappedLargeChip.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            unTappedSmallChip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unTappedSmallChip.topAnchor.constraint(equalTo: unTappedLargeChip.bottomAnchor, constant: 24),
            
            
            tappedLargeChip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tappedLargeChip.topAnchor.constraint(equalTo: unTappedSmallChip.bottomAnchor, constant: 51),
            
            tappedSmallChip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tappedSmallChip.topAnchor.constraint(equalTo: tappedLargeChip.bottomAnchor, constant: 24),
            
            
            disabledLargeChip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            disabledLargeChip.topAnchor.constraint(equalTo: tappedSmallChip.bottomAnchor, constant: 51),
            
            disabledSmallChip.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            disabledSmallChip.topAnchor.constraint(equalTo: disabledLargeChip.bottomAnchor, constant: 24)
        ])
    }
    
    /**
     Chip 작동 함수
     */
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
