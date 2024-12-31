//
//  TabsViewController.swift
//  Handy
//
//  Created by chongin on 12/29/24.
//

import Handy

final class TabsViewController: BaseViewController {
    private let tabs: HandyTabs = {
        let tabs = HandyTabs(sizeType: .small)
        tabs.tabs = [
            {
                let viewController = SnackbarViewController()
                return ("SnackbarViewController", viewController)
            }(),
            {
                let viewController = LabelViewController()
                return ("LabelViewController", viewController)
            }(),
            {
                let viewController = FabViewController()
                return ("FabViewController", viewController)
            }(),
            {
                let viewController = HandyBoxButtonViewController()
                return ("HandyBoxButtonViewController", viewController)
            }(),
            {
                let viewController = ChipViewController()
                return ("ChipViewController", viewController)
            }(),
            {
                let viewController = DividerViewController()
                return ("DividerViewController", viewController)
            }(),
            {
                let viewController = CheckBoxViewController()
                return ("CheckBoxViewController", viewController)
            }(),
            {
                let viewController = RadioButtonViewController()
                return ("RadioButtonViewController", viewController)
            }(),
            {
                let viewController = HansySwitchViewController()
                return ("HansySwitchViewController", viewController)
            }(),
        ]
        return tabs
    }()

    override func setViewHierarchies() {
        self.addChild(tabs)
        self.view.addSubview(tabs.view)
    }

    override func setViewLayouts() {
        tabs.view.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}


import UIKit

open class HandyTabs: UIViewController {
    open var sizeType: HandyTabComponent.SizeType
    open var tabs: [(title: String, viewController: UIViewController)] = [] {
        didSet {
            if tabs.isEmpty {
                selectedIndex = nil
            } else if selectedIndex == nil {
                selectedIndex = 0
            } else if selectedIndex! >= tabs.count {
                selectedIndex = tabs.count - 1
            }

            updateTabsHeaderLayout()
        }
    }
    open var selectedIndex: Int? {
        didSet {
            if let oldValue {
                let previousViewController = tabs[oldValue].viewController
                previousViewController.removeFromParent()
                previousViewController.view.snp.removeConstraints()
                previousViewController.view.removeFromSuperview()
            }

            if let selectedVC = selectedTab?.viewController {
                self.addChild(selectedVC)
                self.tabsContent.addSubview(selectedVC.view)
                selectedVC.view.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                }
            }
        }
    }
    open var selectedTab: (title: String, viewController: UIViewController)? {
        guard let selectedIndex else { return nil }
        return tabs.indices.contains(selectedIndex)
        ? tabs[selectedIndex]
        : nil
    }

    private var tabsHeader: UICollectionView!
    private var tabsContent: UIView!

    private var viewCount: Int {
        self.tabs.count
    }
    private var tabsType: HandyTabsType {
        switch viewCount {
        case 1...3:
            return .fixed(viewCount: viewCount)
        default:
            return .scrollable
        }
    }
    private let tabSpacing: CGFloat = 8.0
    public init(sizeType: HandyTabComponent.SizeType) {
        self.sizeType = sizeType
        super.init(nibName: nil, bundle: nil)
        setTabsHeader()
        setTabsContent()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setTabsHeader() {
        // configure collectionView
        tabsHeader = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        tabsHeader.isScrollEnabled = true
        tabsHeader.allowsMultipleSelection = false
        tabsHeader.showsHorizontalScrollIndicator = false
        tabsHeader.showsVerticalScrollIndicator = false

        self.view.addSubview(tabsHeader)

        tabsHeader.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }

        // register cells
        tabsHeader.register(HandyTabComponent.self, forCellWithReuseIdentifier: HandyTabComponent.reuseIdentifier)

        // set delegates
        tabsHeader.delegate = self
        tabsHeader.dataSource = self
    }

    private func setTabsContent() {
        tabsContent = UIView()

        self.view.addSubview(tabsContent)

        tabsContent.snp.makeConstraints {
            $0.top.equalTo(tabsHeader.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func updateTabsHeaderLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = tabSpacing

        switch tabsType {
        case .scrollable:
            layout.estimatedItemSize = CGSize(width: 0, height: 48)
        case .fixed(let viewCount):
            let totalSpacing = tabSpacing * CGFloat(viewCount - 1)
            let itemWidth = (self.view.frame.width - totalSpacing) / CGFloat(viewCount)
            layout.itemSize = CGSize(width: itemWidth, height: 48)
        }

        tabsHeader.collectionViewLayout = layout
        tabsHeader.collectionViewLayout.invalidateLayout()
    }
}

extension HandyTabs: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewCount
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HandyTabComponent.reuseIdentifier, for: indexPath) as! HandyTabComponent
        cell.sizeType = sizeType
        cell.title = tabs[indexPath.row].title
        return cell
    }

    // 새로운 cell을 선택했을 때 이전 cell은 선택 해제해줍니다.
    // content를 선택한 ViewController로 바꿔줍니다.
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard selectedIndex != indexPath.row else { return }

        let previousIndex = selectedIndex
        selectedIndex = indexPath.row

        collectionView.performBatchUpdates {
            if let previousIndex = previousIndex {
                collectionView.reloadItems(at: [IndexPath(item: previousIndex, section: 0)])
            }
            collectionView.reloadItems(at: [indexPath])
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                if let selectedCell = collectionView.cellForItem(at: indexPath) as? HandyTabComponent {
                    selectedCell.isSelected = true
                }
            }
        }
    }

    // cell의 선택 속성은 willDisplay에서 결정해야 합니다.
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.isSelected = indexPath.row == self.selectedIndex
    }
}

extension HandyTabs {
    public enum HandyTabsType {
        case scrollable
        case fixed(viewCount: Int)
    }
}

open class HandyTabComponent: UICollectionViewCell {
    open var sizeType: SizeType = .large {
        didSet {
            setConfiguration()
        }
    }

    private let titleLabel: HandyLabel = {
        let label = HandyLabel(style: .B1Sb16)
        label.alignment = .center
        return label
    }()
    private let selectedIndicator = UIView()

    open var title: String = "Tab" {
        didSet {
            setTitleLabel()
        }
    }

    open override var isSelected: Bool {
        didSet {
            if oldValue == isSelected { return }
            setConfiguration()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViewHierarchy()
        initializeConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeViewHierarchy() {
        // Set View Hierarchy
        self.addSubview(titleLabel)
        self.addSubview(selectedIndicator)
    }

    private func initializeConstraints() {
        // Set Constraints
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16).priority(999)
            $0.top.bottom.equalToSuperview().inset(12).priority(999)
        }

        selectedIndicator.snp.makeConstraints {
            $0.bottom.equalToSuperview().priority(999)
            $0.leading.trailing.equalToSuperview().inset(18).priority(999)
            $0.height.equalTo(2)
        }

        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
    }

    private func setConfiguration() {
        setTitleLabel()
        setIndicatorBar()
    }

    private func setTitleLabel() {
        titleLabel.text = title
        titleLabel.style = switch sizeType {
        case .small:
            String.HandyTypoStyle.B3Sb14
        case .large:
            String.HandyTypoStyle.B1Sb16
        }
        titleLabel.textColor = switch isSelected {
        case true: HandySemantic.textBasicPrimary
        case false: HandySemantic.textBasicTertiary
        }
    }

    private func setIndicatorBar() {
        selectedIndicator.backgroundColor = HandySemantic.bgBasicBlack
        selectedIndicator.layer.cornerRadius = 1
        selectedIndicator.isHidden = !isSelected
    }
}

extension HandyTabComponent {
    public enum SizeType {
        case small
        case large
    }
}

extension HandyTabComponent {
    static let reuseIdentifier = "HandyTabComponent"
}
