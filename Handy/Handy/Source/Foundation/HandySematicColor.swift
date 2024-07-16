//
//  HandyPrimitiveColor.swift
//  Handy
//
//  Created by 성현주 on 7/17/24.
//

import UIKit

public enum HandySemanticColor {
    private static func color(light: UIColor) -> UIColor {
        return light
    }

    // MARK: - Background

    public static var bgBasicDefault: UIColor {
        return .colorNeutralWhite
    }

    public static var bgBasicLight: UIColor {
        return color(light: .colorGray50)
    }

    public static var bgBasicStrong: UIColor {
        return color(light: .colorGray100)
    }

    public static var bgBasicBlack: UIColor {
        return color(light: .colorNeutralBlack)
    }

    public static var bgBrandPrimary: UIColor {
        return color(light: .colorViolet500)
    }

    public static var bgBrandSecondary: UIColor {
        return color(light: .colorViolet50)
    }

    public static var bgStatusNegative: UIColor {
        return color(light: .colorStatusRedSub)
    }

    public static var bgStatusPositive: UIColor {
        return color(light: .colorViolet500)
    }

    // MARK: - Text

    public static var textBasicPrimary: UIColor {
        return color(light: .colorNeutralBlack)
    }

    public static var textBasicSecondary: UIColor {
        return color(light: .colorGray700)
    }

    public static var textBasicTertiary: UIColor {
        return color(light: .colorGray500)
    }

    public static var textBasicDisabled: UIColor {
        return color(light: .colorGray300)
    }

    public static var textBasicWhite: UIColor {
        return color(light: .colorNeutralBlack)
    }

    public static var textBrandPrimary: UIColor {
        return color(light: .colorViolet500)
    }

    public static var textBrandSecondary: UIColor {
        return color(light: .colorViolet600)
    }

    public static var textStatusNegative: UIColor {
        return color(light: .colorStatusRedMain)
    }

    public static var textStatusPositive: UIColor {
        return color(light: .colorViolet500)
    }

    // MARK: - Line

    public static var lineBasicLight: UIColor {
        return color(light: .colorGray100)
    }

    public static var lineBasicMedium: UIColor {
        return color(light: .colorGray200)
    }

    public static var lineBasicStrong: UIColor {
        return color(light: .colorGray300)
    }

    // MARK: - Button

    public static var buttonBoxPrimaryEnabled: UIColor {
        return color(light: .colorViolet500)
    }

    public static var buttonBoxPrimaryPressed: UIColor {
        return color(light: .colorViolet700)
    }

    public static var buttonBoxPrimaryDisabled: UIColor {
        return color(light: .colorGray100)
    }

    public static var buttonBoxSecondaryEnabled: UIColor {
        return color(light: .colorViolet50)
    }

    public static var buttonBoxSecondaryPressed: UIColor {
        return color(light: .colorViolet200)
    }

    public static var buttonBoxSecondaryDisabled: UIColor {
        return color(light: .colorGray100)
    }

    public static var buttonBoxTertiaryEnabled: UIColor {
        return color(light: .colorGray100)
    }

    public static var buttonBoxTertiaryPressed: UIColor {
        return color(light: .colorGray100)
    }

    public static var buttonBoxTertiaryDisabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var buttonTextPrimaryEnabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var buttonTextPrimaryPressed: UIColor {
        return color(light: .colorViolet50)
    }

    public static var buttonTextPrimaryDisabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var buttonFabPrimaryEnabled: UIColor {
        return color(light: .colorViolet500)
    }

    public static var buttonFabPrimaryPressed: UIColor {
        return color(light: .colorViolet700)
    }

    public static var buttonFabPrimaryDisabled: UIColor {
        return color(light: .colorGray100)
    }

    public static var buttonRadioSelected: UIColor {
        return color(light: .colorViolet500)
    }

    public static var buttonRadioUnselected: UIColor {
        return color(light: .colorGray200)
    }

    public static var buttonRadioDisabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var buttonTextSecondaryEnabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var buttonTextSecondaryPressed: UIColor {
        return color(light: .colorGray100)
    }

    public static var buttonTextSecondaryDisabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var buttonFabSecondaryEnabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var buttonFabSecondaryPressed: UIColor {
        return color(light: .colorGray100)
    }

    public static var buttonFabSecondaryDisabled: UIColor {
        return color(light: .colorNeutralWhite)
    }

    // MARK: - Icon

    public static var iconBasicPrimary: UIColor {
        return color(light: .colorNeutralBlack)
    }

    public static var iconBasicSecondary: UIColor {
        return color(light: .colorGray700)
    }

    public static var iconBasicTertiary: UIColor {
        return color(light: .colorGray500)
    }

    public static var iconBasicDisabled: UIColor {
        return color(light: .colorGray200)
    }

    public static var iconBasicWhite: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var iconBrandPrimary: UIColor {
        return color(light: .colorViolet500)
    }

    public static var iconBrandSecondary: UIColor {
        return color(light: .colorViolet600)
    }

    // MARK: - CheckBox

    public static var checkboxSelected: UIColor {
        return color(light: .colorViolet500)
    }

    public static var checkboxUnSelected: UIColor {
        return color(light: .colorNeutralWhite)
    }

    public static var checkboxDisabled: UIColor {
        return color(light: .colorGray200)
    }
}
