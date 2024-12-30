//
//  TabsViewController.swift
//  Handy
//
//  Created by chongin on 12/29/24.
//

import Handy

final class TabsViewController: BaseViewController {
    private let tabs: HandyTabs = {
        let tabs = HandyTabs(sizeType: .large)
        tabs.tabs = [
            {
                let viewController = UIViewController()
                viewController.view.backgroundColor = .red
                return ("첫번째 탭입니다", viewController)
            }(),
            {
                let viewController = UIViewController()
                viewController.view.backgroundColor = .green
                return ("두번째 탭입니다", viewController)
            }(),
            {
                let viewController = UIViewController()
                viewController.view.backgroundColor = .red
                return ("세번째", viewController)
            }(),
            {
                let viewController = UIViewController()
                viewController.view.backgroundColor = .red
                return ("네번째", viewController)
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
    public var sizeType: HandyTabComponent.SizeType = .large
    public var tabs: [(title: String, viewController: UIViewController)] = [] {
        didSet {
            if tabs.isEmpty {
                selectedIndex = nil
            } else if selectedIndex == nil {
                selectedIndex = 0
            } else if selectedIndex! >= tabs.count {
                selectedIndex = tabs.count - 1
            }

            updateCollectionViewLayout()
        }
    }
    public var selectedIndex: Int? {
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
    public var selectedTab: (title: String, viewController: UIViewController)? {
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
        super.init(nibName: nil, bundle: nil)
        self.sizeType = sizeType
        setTabsHeader()
        setTabsContent()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setTabsHeader() {
        // configure collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = tabSpacing

        tabsHeader = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        tabsHeader.isScrollEnabled = true
        tabsHeader.allowsMultipleSelection = false
        tabsHeader.showsHorizontalScrollIndicator = false
        tabsHeader.showsVerticalScrollIndicator = false
        tabsHeader.backgroundColor = .g400

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
        tabsContent.backgroundColor = .blue

        self.view.addSubview(tabsContent)

        tabsContent.snp.makeConstraints {
            $0.top.equalTo(tabsHeader.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func updateCollectionViewLayout() {
        guard let layout = tabsHeader.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        switch tabsType {
        case .scrollable:
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = tabSpacing
            layout.estimatedItemSize = CGSize(width: 0, height: 48)
        case .fixed(let viewCount):
            let totalSpacing = tabSpacing * CGFloat(viewCount - 1)
            let itemWidth = (self.view.frame.width - totalSpacing) / CGFloat(viewCount)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = tabSpacing
            layout.itemSize = CGSize(width: itemWidth, height: 48)
        }

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
        cell.backgroundColor = .green
        return cell
    }

    // 새로운 cell을 선택했을 때 이전 cell은 선택 해제해줍니다.
    // content를 선택한 ViewController로 바꿔줍니다.
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedIndex else { return }
        let previousIndexPath = IndexPath(item: selectedIndex, section: 0)
        if let previousCell = collectionView.cellForItem(at: previousIndexPath) as? HandyTabComponent {
            previousCell.isSelected = false
        }

        self.selectedIndex = indexPath.row
        let selectedCell = collectionView.cellForItem(at: indexPath) as? HandyTabComponent
        selectedCell?.isSelected = true
    }

    // cell의 선택 속성은 willDisplay에서 결정해야 합니다.
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.isSelected = indexPath.row == selectedIndex
    }
}

extension HandyTabs {
    public enum HandyTabsType {
        case scrollable
        case fixed(viewCount: Int)
    }
}

open class HandyTabComponent: UICollectionViewCell {
    public var sizeType: SizeType = .large {
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

    public var title: String = "Tab" {
        didSet {
            setTitleLabel()
        }
    }

    public override var isSelected: Bool {
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
