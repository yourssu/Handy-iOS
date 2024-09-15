//
//  HandyDivider.swift
//  Handy
//
//  Created by 서준영 on 9/15/24.
//

import UIKit
import SnapKit

public class HandyDivider: UIView {
    
    public enum DividerThickness {
        case thickness1
        case thickness2
        case thickness4
        case thickness8
        
        fileprivate var rawValue: CGFloat {
            switch self {
            case .thickness1:
                return 1
            case .thickness2:
                return 2
            case .thickness4:
                return 4
            case .thickness8:
                return 8
            }
        }
    }
    
    public enum DividerDirection {
        case horizontal
        case vertical
    }
    
    @Invalidating(.layout) public var thickness: DividerThickness = .thickness1 {
        didSet {
            setNeedsUpdateConstraints()
        }
    }
    @Invalidating(.layout) private var direction: DividerDirection = .horizontal
    
    public init(_ direction: DividerDirection) {
        self.direction = direction
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setColor()
    }
    
    private func setColor() {
        self.backgroundColor = HandySemantic.bgBasicStrong
    }
    
    override public func updateConstraints() {
        super.updateConstraints()
        setThickness()
    }
    
    private func setThickness() {
        switch direction {
        case .horizontal:
            self.snp.updateConstraints {
                $0.height.equalTo(thickness.rawValue)
            }
        case .vertical:
            self.snp.updateConstraints {
                $0.width.equalTo(thickness.rawValue)
            }
        }
    }
}
