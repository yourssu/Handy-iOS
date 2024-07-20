//
//  HandyLabel.swift
//  Handy
//
//  Created by 이조은 on 7/19/24.
//

import UIKit

public class HandyLabel: UILabel {
    @Invalidating(.layout) public var style: String.HandyTypoStyle = .D1Sb56

    public override var text: String? {
        didSet { layoutIfNeeded() }
    }

    public override var textColor: UIColor! {
        didSet { setNeedsLayout() }
    }

    public override var lineBreakMode: NSLineBreakMode {
        didSet { setNeedsLayout() }
    }

    public override var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy {
        didSet { setNeedsLayout() }
    }

    public var alignment: NSTextAlignment {
        didSet { setNeedsLayout() }
    }

    public init(style: String.HandyTypoStyle = .D1Sb56) {
        self.style = style
        self.alignment = .left
        super.init(frame: CGRect.zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setAttributedText() {
        guard let text = self.text else { return }
        attributedText = text.attributedString(byPreset: style,
                                               color: textColor,
                                               lineBreakMode: lineBreakMode,
                                               lineBreakStrategy: lineBreakStrategy,
                                               alignment: alignment)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        setAttributedText()
    }
}

