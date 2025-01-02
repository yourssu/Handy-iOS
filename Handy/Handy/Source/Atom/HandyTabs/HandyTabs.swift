//
//  HandyTabs.swift
//  Handy
//
//  Created by chongin on 12/31/24.
//

import UIKit

open class HandyTabs: UIViewController {
    // MARK: - open & public properties
    /// `HandyTabCell`의 크기를 결정합니다.
    open var sizeType: HandyTabCell.SizeType


    /// 보여질 탭의 정보를 의미합니다.
    /// 탭의 개수가 1~3개라면 스크롤 없는 고정된 형태로 표현되며,
    /// 탭의 개수가 4개 이상이라면 스크롤이 생기는 가변 형태로 표현됩니다.
    /// ``HandyTabsType``를 참고해주세요.
    open var tabs: [(title: String, viewController: UIViewController)] = [] {
        didSet {
            if tabs.isEmpty {
                selectedIndex = nil
            } else if selectedIndex == nil {
                selectedIndex = 0
            } else if selectedIndex! >= tabs.count {
                selectedIndex = tabs.count - 1
            }

            tabsHeader.reloadData() // reload 후 layout을 수정해야 정상적으로 작동합니다.

            updateTabsHeaderLayout()
        }
    }
    
    /// 현재 선택되어있는 탭의 인덱스입니다. [0] 부터 시작합니다.
    /// * `nil`인 경우 : 탭이 0개이거나 초기 상태입니다.
    open var selectedIndex: Int? = nil {
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
    
    /// 현재 선택된 Tab의 정보입니다.
    open var selectedTab: (title: String, viewController: UIViewController)? {
        guard let selectedIndex else { return nil }
        return tabs.indices.contains(selectedIndex)
        ? tabs[selectedIndex]
        : nil
    }

    // MARK: - private properties

    /// Tab의 정보 중 `title` 부분이 표현되는 헤더 영역입니다.
    /// `FlowLayout`으로 구성되어 있습니다. cell은 ``HandyTabCell``만 등록되어 있습니다.
    private var tabsHeader: UICollectionView!
    
    /// Tab의 정보 중 `ViewController` 부분이 표현되는 콘텐츠 영역입니다.
    /// 헤더 뷰를 제외한 ``HandyTabs``의 나머지 영역을 모두 포함합니다.
    private var tabsContent: UIView!
    
    /// 현재 탭의 타입을 의미하는 계산 프로퍼티입니다.
    private var tabsType: HandyTabsType {
        switch self.tabs.count {
        case 1...3:
            return .fixed(viewCount: self.tabs.count)
        default:
            return .scrollable
        }
    }

    // MARK: - Init
    public init(sizeType: HandyTabCell.SizeType) {
        self.sizeType = sizeType
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setTabsHeader()
        setTabsContent()
    }

    // MARK: - private methods

    /// Tabs Header 부분을 만드는 메소드입니다.
    ///
    /// collectionView를 만들고, addSubview()를 수행하고, constraints를 설정하고, cell을 등록하며, delegate를 지정합니다.
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
        tabsHeader.register(HandyTabCell.self, forCellWithReuseIdentifier: HandyTabCell.reuseIdentifier)

        // set delegates
        tabsHeader.delegate = self
        tabsHeader.dataSource = self
    }
    
    /// Tabs Content 부분을 만드는 메소드입니다.
    ///
    /// content 영역을 만들고, addSubview()를 수행하고, constraints를 설정합니다.
    private func setTabsContent() {
        tabsContent = UIView()

        self.view.addSubview(tabsContent)

        tabsContent.snp.makeConstraints {
            $0.top.equalTo(tabsHeader.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    /// 헤더 영역의 layout을 수정하는 메소드입니다.
    ///
    /// tabs의 정보가 바뀌면 그 개수에 따라 고정형 or 가변형으로 해야 합니다.
    ///
    /// 고정형(fixed)일 때 : 개수에 따라 width를 계산하여 지정합니다.
    /// 가변형(scrollable)일 때 : estimatedItemSize만 결정하여 텍스트의 크기만큼 너비가 조절되도록 해둡니다.
    private func updateTabsHeaderLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0

        switch tabsType {
        case .scrollable:
            layout.estimatedItemSize = CGSize(width: 10, height: 48)

            self.tabsHeader.isScrollEnabled = true
        case .fixed(let tabCount):
            let itemWidth = self.view.bounds.width / CGFloat(tabCount)
            layout.itemSize = CGSize(width: itemWidth, height: 48)

            self.tabsHeader.isScrollEnabled = false
        }

        tabsHeader.collectionViewLayout = layout
        tabsHeader.collectionViewLayout.invalidateLayout()
    }
}

extension HandyTabs: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.tabs.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HandyTabCell.reuseIdentifier, for: indexPath) as! HandyTabCell
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
                if let selectedCell = collectionView.cellForItem(at: indexPath) as? HandyTabCell {
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

