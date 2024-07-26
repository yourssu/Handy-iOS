//
//  HandyColor.swift
//  Handy
//
//  Created by 성현주 on 7/15/24.
//

import UIKit

internal extension UIColor {

    // MARK: - Violet

    static var violet50: UIColor {
        return UIColor.load(name: "v_50")
    }

    static var violet100: UIColor {
        return UIColor.load(name: "v_100")
    }

    static var violet200: UIColor {
        return UIColor.load(name: "v_200")
    }

    static var violet300: UIColor {
        return UIColor.load(name: "v_300")
    }

    static var violet400: UIColor {
        return UIColor.load(name: "v_400")
    }

    static var violet500: UIColor {
        return UIColor.load(name: "v_500")
    }

    static var violet600: UIColor {
        return UIColor.load(name: "v_600")
    }

    static var violet700: UIColor {
        return UIColor.load(name: "v_700")
    }

    static var violet800: UIColor {
        return UIColor.load(name: "v_800")
    }

    static var violet900: UIColor {
        return UIColor.load(name: "v_900")
    }

    static var violet950: UIColor {
        return UIColor.load(name: "v_950")
    }

    // MARK: - Gray

    static var gray50: UIColor {
        return UIColor.load(name: "g_50")
    }

    static var gray100: UIColor {
        return UIColor.load(name: "g_100")
    }

    static var gray200: UIColor {
        return UIColor.load(name: "g_200")
    }

    static var gray300: UIColor {
        return UIColor.load(name: "g_300")
    }

    static var gray400: UIColor {
        return UIColor.load(name: "g_400")
    }

    static var gray500: UIColor {
        return UIColor.load(name: "g_500")
    }

    static var gray600: UIColor {
        return UIColor.load(name: "g_600")
    }

    static var gray700: UIColor {
        return UIColor.load(name: "g_700")
    }

    static var gray800: UIColor {
        return UIColor.load(name: "g_800")
    }

    static var gray900: UIColor {
        return UIColor.load(name: "g_900")
    }

    static var gray950: UIColor {
        return UIColor.load(name: "g_950")
    }

    // MARK: - Neutral

    static var black: UIColor {
        return UIColor.load(name: "black")
    }

    static var white: UIColor {
        return UIColor.load(name: "white")
    }

    static var transparent: UIColor {
        return UIColor.clear
    }


    // MARK: - Status

    static var redMain: UIColor {
        return UIColor.load(name: "r_main")
    }

    static var redSub: UIColor {
        return UIColor.load(name: "r_sub")
    }
}


fileprivate extension UIColor {
    static func load(name: String) -> UIColor {
        guard let color = UIColor(named: name, in: nil, compatibleWith: nil) else {
            assert(false, "\(name) 컬러 로드 실패")
            return UIColor.clear
        }
        return color
    }
}
