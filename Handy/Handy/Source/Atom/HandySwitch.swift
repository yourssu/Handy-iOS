//
//  HandySwitch.swift
//  Handy
//
//  Created by 이조은 on 9/18/24.
//

import UIKit

final public class HandySwitch: UISwitch {

    // MARK: - 외부에서 지정할 수 있는 속성
    @Invalidating(.layout, .display) public var isDisabled: Bool = false
    
    @Invalidating(.display) public var size: SwitchSize = .medium {
        didSet {
            updateSwitchSize() // size가 변경될 때 크기 변경
        }
    }

    public override var isOn: Bool {
        didSet { setNeedsDisplay() }
    }

    // MARK: - 외부에서 접근할 수 있는 enum
    public enum SwitchSize {
        case large
        case medium
        case small

        fileprivate var ratio: CGFloat {
            switch self {
            case .large:
                return 1.0
            case .medium:
                return 0.7
            case .small:
                return 0.5
            }
        }

        fileprivate var switchWidth: CGFloat {
            return 51.0 * self.ratio
        }

        fileprivate var switchHeight: CGFloat {
            return 31.0 * self.ratio
        }
    }

    // MARK: - 내부에서 사용되는 변수
    private var fgColor: UIColor?
    private var bgColor: UIColor?

    // MARK: - 메소드

    public init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setSwitchColor()
        updateSwitchSize()
    }

    private func setSwitchColor() {
        self.subviews.first?.subviews.first?.backgroundColor = HandySemantic.switchUnselected
        self.onTintColor = HandySemantic.switchSelected
    }

    private func updateSwitchSize() {
        self.transform = CGAffineTransform(scaleX: size.ratio, y: size.ratio)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        isEnabled = !isDisabled
        setSwitchColor()
    }
}
