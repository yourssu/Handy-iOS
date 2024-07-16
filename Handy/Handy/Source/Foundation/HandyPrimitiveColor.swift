//
//  HandyColor.swift
//  Handy
//
//  Created by 성현주 on 7/15/24.
//

import UIKit

internal extension UIColor {

    // MARK: - Violet

    static var colorViolet50: UIColor {
        return UIColor.load(name: "violet_50")
    }

    static var colorViolet100: UIColor {
        return UIColor.load(name: "violet_100")
    }

    static var colorViolet200: UIColor {
        return UIColor.load(name: "violet_200")
    }

    static var colorViolet300: UIColor {
        return UIColor.load(name: "violet_300")
    }

    static var colorViolet400: UIColor {
        return UIColor.load(name: "violet_400")
    }

    static var colorViolet500: UIColor {
        return UIColor.load(name: "violet_500")
    }

    static var colorViolet600: UIColor {
        return UIColor.load(name: "violet_600")
    }

    static var colorViolet700: UIColor {
        return UIColor.load(name: "violet_700")
    }

    static var colorViolet800: UIColor {
        return UIColor.load(name: "violet_800")
    }

    static var colorViolet900: UIColor {
        return UIColor.load(name: "violet_900")
    }

    static var colorViolet950: UIColor {
        return UIColor.load(name: "violet_950")
    }

    // MARK: - Gray

    static var colorGray50: UIColor {
        return UIColor.load(name: "gray_50")
    }

    static var colorGray100: UIColor {
        return UIColor.load(name: "gray_100")
    }

    static var colorGray200: UIColor {
        return UIColor.load(name: "gray_200")
    }

    static var colorGray300: UIColor {
        return UIColor.load(name: "gray_300")
    }

    static var colorGray400: UIColor {
        return UIColor.load(name: "gray_400")
    }

    static var colorGray500: UIColor {
        return UIColor.load(name: "gray_500")
    }

    static var colorGray600: UIColor {
        return UIColor.load(name: "gray_600")
    }

    static var colorGray700: UIColor {
        return UIColor.load(name: "gray_700")
    }

    static var colorGray800: UIColor {
        return UIColor.load(name: "gray_800")
    }

    static var colorGray900: UIColor {
        return UIColor.load(name: "gray_900")
    }

    static var colorGray950: UIColor {
        return UIColor.load(name: "gray_950")
    }

    // MARK: - Neutral

    static var colorNeutralBlack: UIColor {
        return UIColor.load(name: "black")
    }

    static var colorNeutralWhite: UIColor {
        return UIColor.load(name: "white")
    }


    // MARK: - Status

    static var colorStatusRedMain: UIColor {
        return UIColor.load(name: "red_main")
    }

    static var colorStatusRedSub: UIColor {
        return UIColor.load(name: "red_sub")
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
