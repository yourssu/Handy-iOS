//
//  HandyColor.swift
//  Handy
//
//  Created by 성현주 on 7/15/24.
//

import UIKit

internal extension UIColor {

    // MARK: - Primary

    // MARK: - Gray

    static var gray050: UIColor {
        return UIColor.load(name: "gray_50")
    }

    static var gray100: UIColor {
        return UIColor.load(name: "gray_100")
    }

    static var gray200: UIColor {
        return UIColor.load(name: "gray_200")
    }

    static var gray300: UIColor {
        return UIColor.load(name: "gray_300")
    }

    static var gray400: UIColor {
        return UIColor.load(name: "gray400")
    }

    static var gray500: UIColor {
        return UIColor.load(name: "gray500")
    }

    static var gray600: UIColor {
        return UIColor.load(name: "gray600")
    }

    static var gray700: UIColor {
        return UIColor.load(name: "gray700")
    }

    static var gray800: UIColor {
        return UIColor.load(name: "gray800")
    }

    static var gray900: UIColor {
        return UIColor.load(name: "gray900")
    }

    // MARK: - Neutral


    // MARK: - Status
}


fileprivate extension UIColor {
    static func load(name: String) -> UIColor {
        guard let color = UIColor(named: name, in: .ydsEssential, compatibleWith: nil) else {
            assert(false, "\(name) 컬러 로드 실패")
            return UIColor.clear
        }
        return color
    }
}
