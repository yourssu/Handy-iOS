//
//  HandyIcon.swift
//  Handy
//
//  Created by 성현주 on 7/24/24.
//

import UIKit

public enum HandyIcon {
    public static var icCancelFilled: UIImage { .load(name: "icCancelFilled") }
    public static var icCancelLine: UIImage { .load(name: "icCancelLine") }

    public static var checkBoxFilled: UIImage { .load(name: "checkBoxFilled") }
    public static var checkBoxLine: UIImage { .load(name: "checkBoxLine") }
    public static var radioButtonLine: UIImage { .load(name: "radioButtonLine") }
    public static var radioButtonDisabled: UIImage { .load(name: "radioButtonDisabled") }
}

extension UIImage {
    fileprivate static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }

    internal func resize(to length: CGFloat) -> UIImage {
        let newSize = CGSize(width: length, height: length)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }

        return image
    }
}
