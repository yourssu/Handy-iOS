//
//  HandyTextFieldConstants.swift
//  Handy
//
//  Created by 정민지 on 11/18/24.
//

import UIKit

internal struct HandyTextFieldConstants {
    internal enum Dimension {
        
        /**
         텍스트 필드 좌측 마진값입니다.
         */
        static let leftMargin: CGFloat = 16
        
        /**
         텍스트 필드 우측 마진값입니다.
         */
        static let rightMargin: CGFloat = (clearButtonDefaultRightMargin * 2) + clearButtonSize
        
        /**
         텍스트 필드 높이입니다.
         */
        static let textFieldHeight: CGFloat = 48
        
        /**
         Label, TextField,  Helper text 내부 요소 간 간격입니다.
         */
        static let subviewSpacing: CGFloat = 4
        
        /**
         clearButton과  TextField 사이 값 (=clearButton의 우측 마진)입니다.
         */
        static let clearButtonDefaultRightMargin: CGFloat = 12
        
        /**
         clearButton 크기입니다.
         */
        static let clearButtonSize: CGFloat = 20
        
        /**
         Label,  Helper text가 TextField보다 왼쪽으로 더 들어가있는 Inset 값 입니다.
         */
        static let labelInsetWidth: CGFloat = 4
    }
}
