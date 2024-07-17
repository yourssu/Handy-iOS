//
//  HandySemantic.swift
//  Handy
//
//  Created by 성현주 on 7/17/24.
//

import UIKit

public enum HandySemantic {

    // MARK: - Background

    public static var bgBasicDefault: UIColor {
        return .white
    }

    public static var bgBasicLight: UIColor {
        return .gray50
    }

    public static var bgBasicStrong: UIColor {
        return .gray100
    }

    public static var bgBasicBlack: UIColor {
        return .black
    }

    public static var bgBrandPrimary: UIColor {
        return .violet500
    }

    public static var bgBrandSecondary: UIColor {
        return .violet50
    }

    public static var bgStatusNegative: UIColor {
        return .redSub
    }

    public static var bgStatusPositive: UIColor {
        return .violet500
    }

    // MARK: - Text

    public static var textBasicPrimary: UIColor {
        return .black
    }

    public static var textBasicSecondary: UIColor {
        return .gray700
    }

    public static var textBasicTertiary: UIColor {
        return .gray500
    }

    public static var textBasicDisabled: UIColor {
        return .gray300
    }

    public static var textBasicWhite: UIColor {
        return .black
    }

    public static var textBrandPrimary: UIColor {
        return .violet500
    }

    public static var textBrandSecondary: UIColor {
        return .violet600
    }

    public static var textStatusNegative: UIColor {
        return .redMain
    }

    public static var textStatusPositive: UIColor {
        return .violet500
    }

    // MARK: - Line

    public static var lineBasicLight: UIColor {
        return .gray100
    }

    public static var lineBasicMedium: UIColor {
        return .gray200
    }

    public static var lineBasicStrong: UIColor {
        return .gray300
    }

    // MARK: - Button

    public static var buttonBoxPrimaryEnabled: UIColor {
        return .violet500
    }

    public static var buttonBoxPrimaryPressed: UIColor {
        return .violet700
    }

    public static var buttonBoxPrimaryDisabled: UIColor {
        return .gray100
    }

    public static var buttonBoxSecondaryEnabled: UIColor {
        return .violet50
    }

    public static var buttonBoxSecondaryPressed: UIColor {
        return .violet200
    }

    public static var buttonBoxSecondaryDisabled: UIColor {
        return .gray100
    }

    public static var buttonBoxTertiaryEnabled: UIColor {
        return .transparent
    }

    public static var buttonBoxTertiaryPressed: UIColor {
        return .gray100
    }

    public static var buttonBoxTertiaryDisabled: UIColor {
        return .transparent
    }

    public static var buttonTextPrimaryEnabled: UIColor {
        return .transparent
    }

    public static var buttonTextPrimaryPressed: UIColor {
        return .violet50
    }

    public static var buttonTextPrimaryDisabled: UIColor {
        return .transparent
    }

    public static var buttonFabPrimaryEnabled: UIColor {
        return .violet500
    }

    public static var buttonFabPrimaryPressed: UIColor {
        return .violet700
    }

    public static var buttonFabPrimaryDisabled: UIColor {
        return .gray100
    }

    public static var buttonRadioSelected: UIColor {
        return .violet500
    }

    public static var buttonRadioUnselected: UIColor {
        return .gray200
    }

    public static var buttonRadioDisabled: UIColor {
        return .white
    }

    public static var buttonTextSecondaryEnabled: UIColor {
        return .transparent
    }

    public static var buttonTextSecondaryPressed: UIColor {
        return .gray100
    }

    public static var buttonTextSecondaryDisabled: UIColor {
        return .transparent
    }

    public static var buttonFabSecondaryEnabled: UIColor {
        return .white
    }

    public static var buttonFabSecondaryPressed: UIColor {
        return .gray100
    }

    public static var buttonFabSecondaryDisabled: UIColor {
        return .white
    }

    // MARK: - Icon

    public static var iconBasicPrimary: UIColor {
        return .black
    }

    public static var iconBasicSecondary: UIColor {
        return .gray700
    }

    public static var iconBasicTertiary: UIColor {
        return .gray500
    }

    public static var iconBasicDisabled: UIColor {
        return .gray200
    }

    public static var iconBasicWhite: UIColor {
        return .white
    }

    public static var iconBrandPrimary: UIColor {
        return .violet500
    }

    public static var iconBrandSecondary: UIColor {
        return .violet600
    }

    // MARK: - CheckBox

    public static var checkboxSelected: UIColor {
        return .violet500
    }

    public static var checkboxUnSelected: UIColor {
        return .white
    }

    public static var checkboxDisabled: UIColor {
        return .gray200
    }

    // MARK: - Spacing

    public static var spacingRadiusXS: Int {
        return HandyPrimitive.spacing8
    }

    public static var spacingRadiusS: Int {
        return HandyPrimitive.spacing10
    }

    public static var spacingRadiusM: Int {
        return HandyPrimitive.spacing12
    }

    public static var spacingRadiusL: Int {
        return HandyPrimitive.spacing14
    }

    public static var spacingRadiusXL: Int {
        return HandyPrimitive.spacing16
    }

    // MARK: - Chip

    public static var chipSelected: UIColor {
        return .redMain
    }

    public static var chipUnselected: UIColor {
        return .redSub
    }

    public static var chipDisabled: UIColor {
        return .redSub
    }

    // MARK: - Pagination

    public static var paginationBrandPressed: UIColor {
        return .redMain
    }

    public static var paginationBasicSelected: UIColor {
        return .redSub
    }

    public static var paginationBasicUnSelected: UIColor {
        return .redMain
    }
}
