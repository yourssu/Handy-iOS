//
//  HandyButtonProtocol.swift
//  Handy
//
//  Created by 이조은 on 7/25/24.
//

import UIKit

/**
 HandyBoxButton과 HandyTextButton이 준수하는 protocol입니다.
 */
public protocol HandyButtonProtocol {
    var isDisabled: Bool { get set }
    var text: String? { get set }
    var leftIcon: UIImage? { get set }
    var rightIcon: UIImage? { get set }
}
