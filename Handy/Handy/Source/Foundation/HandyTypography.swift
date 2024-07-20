//
//  HandyTypography.swift
//  Handy
//
//  Created by 이조은 on 7/19/24.
//

import UIKit

extension String {
    public enum TypoStyle {
        case D1Sb56
        case D1Rg56
        case D1Lt56

        case D2Sb48
        case D2Rg48
        case D2Lt48

        case D3Sb40
        case D3Rg40
        case D3Lt40

        case D4Sb36
        case D4Rg36
        case D4Lt36

        case H1Sb32
        case H1Rg32
        case H1Lt32

        case H2Sb28
        case H2Rg28
        case H2Lt28

        case H3Sb24
        case H3Rg24
        case H3Lt24

        case T1Sb20
        case T1Rg20
        case T1Lt20

        case T2Sb18
        case T2Rg18
        case T2Lt18

        case B1Sb16
        case B1Rg16
        case B1Lt16

        case B2Sb15
        case B2Rg15
        case B2Lt15

        case B3Sb14
        case B3Rg14
        case B3Lt14

        case B4Sb13
        case B4Rg13
        case B4Lt13

        case B5Sb12
        case B5Rg12
        case B5Lt12

        case C1Sb11
        case C1Rg11
        case C1Lt11

        // MARK: - 폰트

        public var font: UIFont {
            switch self {
            case .D1Sb56:
                return HandyFont.D1Sb56
            case .D1Rg56:
                return HandyFont.D1Rg56
            case .D1Lt56:
                return HandyFont.D1Lt56

            case .D2Sb48:
                return HandyFont.D2Sb48
            case .D2Rg48:
                return HandyFont.D2Rg48
            case .D2Lt48:
                return HandyFont.D2Lt48

            case .D3Sb40:
                return HandyFont.D3Sb40
            case .D3Rg40:
                return HandyFont.D3Rg40
            case .D3Lt40:
                return HandyFont.D3Lt40

            case .D4Sb36:
                return HandyFont.D4Sb36
            case .D4Rg36:
                return HandyFont.D4Rg36
            case .D4Lt36:
                return HandyFont.D4Lt36

            case .H1Sb32:
                return HandyFont.H1Sb32
            case .H1Rg32:
                return HandyFont.H1Rg32
            case .H1Lt32:
                return HandyFont.H1Lt32

            case .H2Sb28:
                return HandyFont.H2Sb28
            case .H2Rg28:
                return HandyFont.H2Rg28
            case .H2Lt28:
                return HandyFont.H2Lt28

            case .H3Sb24:
                return HandyFont.H3Sb24
            case .H3Rg24:
                return HandyFont.H3Rg24
            case .H3Lt24:
                return HandyFont.H3Lt24

            case .T1Sb20:
                return HandyFont.T1Sb20
            case .T1Rg20:
                return HandyFont.T1Rg20
            case .T1Lt20:
                return HandyFont.T1Lt20

            case .T2Sb18:
                return HandyFont.T2Sb18
            case .T2Rg18:
                return HandyFont.T2Rg18
            case .T2Lt18:
                return HandyFont.T2Lt18

            case .B1Sb16:
                return HandyFont.B1Sb16
            case .B1Rg16:
                return HandyFont.B1Rg16
            case .B1Lt16:
                return HandyFont.B1Lt16

            case .B2Sb15:
                return HandyFont.B2Sb15
            case .B2Rg15:
                return HandyFont.B2Rg15
            case .B2Lt15:
                return HandyFont.B2Lt15

            case .B3Sb14:
                return HandyFont.B3Sb14
            case .B3Rg14:
                return HandyFont.B3Rg14
            case .B3Lt14:
                return HandyFont.B3Lt14

            case .B4Sb13:
                return HandyFont.B4Sb13
            case .B4Rg13:
                return HandyFont.B4Rg13
            case .B4Lt13:
                return HandyFont.B4Lt13

            case .B5Sb12:
                return HandyFont.B5Sb12
            case .B5Rg12:
                return HandyFont.B5Rg12
            case .B5Lt12:
                return HandyFont.B5Lt12

            case .C1Sb11:
                return HandyFont.C1Sb11
            case .C1Rg11:
                return HandyFont.C1Rg11
            case .C1Lt11:
                return HandyFont.C1Lt11
            }
        }

        // MARK: - 행간

        public var lineHeight: CGFloat {
            switch self {
            case .D1Sb56, .D1Rg56, .D1Lt56:
                return 1.07

            case .D2Sb48, .D2Rg48, .D2Lt48,
                    .D3Sb40, .D3Rg40, .D3Lt40:
                return 1.08

            case .D4Sb36, .D4Rg36, .D4Lt36:
                return 1.02

            case .H1Sb32, .H1Rg32, .H1Lt32:
                return 1.09

            case .H2Sb28, .H2Rg28, .H2Lt28:
                return 1.13

            case .H3Sb24, .H3Rg24, .H3Lt24:
                return 1.18

            case .T1Sb20, .T1Rg20, .T1Lt20:
                return 1.17

            case .T2Sb18, .T2Rg18, .T2Lt18:
                return 1.2

            case .B1Sb16, .B1Rg16, .B1Lt16:
                return 1.25

            case .B2Sb15, .B2Rg15, .B2Lt15:
                return 1.22

            case .B3Sb14, .B3Rg14, .B3Lt14:
                return 1.19

            case .B4Sb13, .B4Rg13, .B4Lt13:
                return 1.15

            case .B5Sb12, .B5Rg12, .B5Lt12:
                return 1.25

            case .C1Sb11, .C1Rg11, .C1Lt11:
                return 1.21
            }
        }

        // MARK: - 자간

        public var letter: CGFloat {
            switch self {
            case .D1Sb56, .D1Rg56, .D1Lt56:
                return -1.12

            case .D2Sb48, .D2Rg48, .D2Lt48:
                return -0.96

            case .D3Sb40, .D3Rg40, .D3Lt40:
                return -0.8

            case .D4Sb36, .D4Rg36, .D4Lt36:
                return -0.72

            case .H1Sb32, .H1Rg32, .H1Lt32:
                return -0.64

            case .H2Sb28, .H2Rg28, .H2Lt28:
                return -0.56

            case .H3Sb24, .H3Rg24, .H3Lt24:
                return -0.48

            case .T1Sb20, .T1Rg20, .T1Lt20:
                return -0.4

            case .T2Sb18, .T2Rg18, .T2Lt18:
                return -0.36

            case .B1Sb16, .B1Rg16, .B1Lt16:
                return -0.32

            case .B2Sb15, .B2Rg15, .B2Lt15:
                return -0.3

            case .B3Sb14, .B3Rg14, .B3Lt14:
                return -0.28

            case .B4Sb13, .B4Rg13, .B4Lt13:
                return -0.26

            case .B5Sb12, .B5Rg12, .B5Lt12:
                return -0.24

            case .C1Sb11, .C1Rg11, .C1Lt11:
                return -0.22
            }
        }

        internal func style(color: UIColor? = nil,
                            lineBreakMode: NSLineBreakMode? = nil,
                            lineBreakStrategy: NSParagraphStyle.LineBreakStrategy? = nil,
                            alignment: NSTextAlignment? = nil) -> [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()

            paragraphStyle.lineHeightMultiple = self.font.lineHeight
            if let lineBreakMode = lineBreakMode {
                paragraphStyle.lineBreakMode = lineBreakMode
            }
            if let lineBreakStrategy = lineBreakStrategy {
                paragraphStyle.lineBreakStrategy = lineBreakStrategy
            }
            if let alignment = alignment {
                paragraphStyle.alignment = alignment
            }
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: color ?? UIColor.black,
                .font: self.font,
                .kern: self.letter,
                .paragraphStyle: paragraphStyle
            ]
            return attributes
        }

    }

    internal func attributedString(byPreset preset: TypoStyle,
                                   color: UIColor? = nil,
                                   lineBreakMode: NSLineBreakMode? = nil,
                                   lineBreakStrategy: NSParagraphStyle.LineBreakStrategy? = nil,
                                   alignment: NSTextAlignment? = nil ) -> NSAttributedString {
        return NSAttributedString.init(string: self,
                                       attributes: preset.style(color: color,
                                                                lineBreakMode: lineBreakMode,
                                                                lineBreakStrategy: lineBreakStrategy,
                                                                alignment: alignment))
    }
}
