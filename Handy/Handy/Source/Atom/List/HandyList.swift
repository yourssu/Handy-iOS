//
//  HandyList.swift
//  Handy
//
//  Created by 이조은 on 11/18/24.
//

import UIKit

final public class HandyList: UIView {

    /**
     HandyList 요소들을 담는 StackView
     */

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()

    public init() {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        setViewHierarchy()
        setAutolayout()
    }

    private func setViewHierarchy() {
        self.addSubview(stackView)
    }

    private func setAutolayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    public func addArrangedSubview(_ views: UIView...) {
        for view in views {
            self.stackView.addArrangedSubview(view)
        }
    }

}
