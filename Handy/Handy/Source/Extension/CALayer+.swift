//
//  CALayer+.swift
//  Handy
//
//  Created by chongin on 1/2/25.
//

import UIKit

extension CALayer {
    
    /// view의 layer에서 특정 모서리에만 border를 적용시킵니다.
    /// - Parameters:
    ///   - edges: 적용하고 싶은 모서리의 방향입니다. `.top`, `.bottom,` `.left`, `.right`를 사용할 수 있습니다. `.all`은 사용할 수 없습니다.
    ///   - color: border의 색상입니다.
    ///   - width: border의 두께입니다.
    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {
        edges.forEach { edge in
            let border = CALayer()
            switch edge {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            border.backgroundColor = color.cgColor
            addSublayer(border)
        }
    }
}
