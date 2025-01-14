//
//  HandyNavigation.swift
//  Handy
//
//  Created by 서준영 on 11/7/24.
//

import UIKit

open class HandyNavigation: UITabBarController {
    
    /// 내부에서 사용되는 레이아웃 수치입니다.
    let itemImageVerticalInset: CGFloat = 10
    
    /// 상단 탭바에 사용되는 디바이더입니다.
    let divider = HandyDivider()
    
    /// 탭바아이템 이미지를 중앙에 놓을지 결정하는 프로퍼티입니다.
    public var centerItem: Bool = false
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    /// 뷰 세팅
    private func setupView() {
        setProperties()
        setLayouts()
    }
    
    /// 프로퍼티 세팅
    private func setProperties() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명한 배경으로 설정
        appearance.backgroundColor = HandySemantic.bgBasicDefault
        appearance.shadowColor = .clear // 탭바 그림자 제거
        
        // 탭바 아이템 설정
        /// 기본 설정
        let tabBarItemAppearance = UITabBarItemAppearance(style: .stacked)
        tabBarItemAppearance.normal.iconColor = HandySemantic.iconBasicDisabled // 아이콘 색상
        tabBarItemAppearance.normal.titleTextAttributes = [
            .foregroundColor: HandySemantic.textBasicDisabled, // 텍스트 색상
            .font: HandyFont.C1Rg11] // 텍스트 폰트
        
        /// 선택 되었을 때 설정
        tabBarItemAppearance.selected.iconColor = HandySemantic.iconBasicPrimary // 선택된 아이콘 색상
        tabBarItemAppearance.selected.titleTextAttributes = [
            .foregroundColor: HandySemantic.textBasicPrimary, // 선택된 텍스트 색상
            .font: HandyFont.C1Rg11] // 텍스트 폰트
        
        // appearance의 각 레이아웃 스타일에 탭바 아이템 외형 설정을 적용
        appearance.stackedLayoutAppearance = tabBarItemAppearance
        appearance.compactInlineLayoutAppearance = tabBarItemAppearance
        appearance.inlineLayoutAppearance = tabBarItemAppearance
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    /// 레이아웃 세팅
    private func setLayouts() {
        tabBar.addSubview(divider)
        divider.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}

//MARK: - 탭바 높이 설정
extension HandyNavigation {
    /// UITabBarController의 tabBar의 frame을 새로 정의하여 tabBar의 높이를 조절합니다.
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Safe Area를 고려한 높이 설정
        let fixedHeight: CGFloat = 56
        var newFrame = tabBar.frame
        
        let safeAreaInsets: CGFloat = {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                return window.safeAreaInsets.bottom
            }
            return 0
        }()
        
        // 탭 바 높이 설정
        newFrame.size.height = fixedHeight + safeAreaInsets
        newFrame.origin.y = view.frame.height - newFrame.size.height
        tabBar.frame = newFrame
    }
}

//MARK: - 탭바 아이템 중앙 정렬
extension HandyNavigation {
    open override var viewControllers: [UIViewController]? {
        didSet { setTabBarItemImageInsets() }
    }
    
    open override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: true)
        setTabBarItemImageInsets()
    }
    
    /// centerItem이 true라면 title을 nil로 설정하고, imageInsets을 조정해서 image를 중앙 정렬합니다.
    public func setTabBarItemImageInsets() {
        viewControllers?.forEach {
            if centerItem == true {
                $0.tabBarItem.title = nil
                $0.tabBarItem.imageInsets = UIEdgeInsets(top: itemImageVerticalInset, left: 0, bottom: -itemImageVerticalInset, right: 0)
            } else {
                tabBarItem.imageInsets = UIEdgeInsets(
                    top: itemImageVerticalInset,
                    left: 0,
                    bottom: 0,
                    right: 0
                )
            }
        }
    }
}
