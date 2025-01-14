//
//  HandyTextViewConstants.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit

internal struct HandyTextViewConstants {
    internal enum Dimension {
        /**
         텍스트뷰의 텍스트 입력 영역 여백 값입니다.
         */
        static let textContainerInset: CGFloat = 16
        
        /**
         텍스트 뷰 최소 높이입니다.
         */
        static let textViewHeight: CGFloat = 48
        
        /**
         placeholder 높이입니다.
         */
        static let helperLabelHeight: CGFloat = 18
        
        /**
         텍스트뷰의 스크롤바  여백 값입니다.
         */
        static let scrollIndicatorInsets: CGFloat = 8
        
        /**
         Label, TextView 내부 요소 간 간격입니다.
         */
        static let subviewSpacing: CGFloat = 4
        
        /**
         Helper text가 TextView보다 왼쪽으로 더 들어가있는 Inset 값 입니다.
         */
        static let labelInsetWidth: CGFloat = 4
    }
}
