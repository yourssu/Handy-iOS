//
//  HandyTabBar.swift
//  Handy
//
//  Created by 오동규 on 7/30/24.
//

//
//  HandyTabBar.swift
//  Handy
//
//  Created by 오동규 on 7/30/24.
//

import UIKit

public class HandyTabBar: UIViewController {

    // SegmentedControl 담을 뷰
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()


        segment.selectedSegmentTintColor = .clear

        // 배경 색 제거
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        // Segment 구분 라인 제거
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        segment.insertSegment(withTitle: "First Tab", at: 0, animated: true)
        segment.insertSegment(withTitle: "Second Tab", at: 1, animated: true)

        segment.selectedSegmentIndex = 0

        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .normal)

        // 선택 되었을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)

        segment.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)

        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()

    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // 움직일 underLineView의 leadingAnchor 따로 작성
    private lazy var leadingDistance: NSLayoutConstraint = {
        return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
    }()


    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        view.addSubview(containerView)
        containerView.addSubview(segmentControl)
        containerView.addSubview(underLineView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //containerView.widthAnchor.constraint(equalToConstant: 250),
            //containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40),

            segmentControl.topAnchor.constraint(equalTo: containerView.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            segmentControl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            segmentControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            //
            underLineView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 5),
            leadingDistance,
            underLineView.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments))
        ])
    }

    @objc private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
        let segmentWidth = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.leadingDistance.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }

}

//import UIKit
//import SnapKit
//import Parchment
//
//public class YDSTabBarViewController: UIViewController {
//    public init(type: PagingViewController.TabBarType, viewControllers: [UIViewController]) {
//        let pagingViewController: PagingViewController = PagingViewController(type: type,
//                                                                              viewControllers: viewControllers,
//                                                                              font: YDSFont.button2,
//                                                                              selectedFont: YDSFont.button2,
//                                                                              textColor: YDSColor.bottomBarNormal,
//                                                                              selectedTextColor: YDSColor.bottomBarSelected,
//                                                                              indicatorColor: YDSColor.bottomBarSelected)
//
//        super.init(nibName: nil, bundle: nil)
//
//        addChild(pagingViewController)
//        view.addSubview(pagingViewController.view)
//
//        pagingViewController.view.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//
//        pagingViewController.didMove(toParent: self)
//    }
//
//    public required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//import UIKit
//import SnapKit
//import Tabman
//import Pageboy
//
//public class YDSTabBarViewController: TabmanViewController, TMBarDataSource, PageboyViewControllerDataSource {
//    public func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
//        // 각 탭에 대한 제목을 설정합니다. 필요에 따라 아이콘을 설정할 수도 있습니다.
//                let titles = ["Home", "Search", "Profile", "Settings"]
//                let title = titles[index]
//                return TMBarItem(title: title)
//    }
//
//
//    private var viewControllers: [UIViewController]
//
//    public init(viewControllers: [UIViewController]) {
//        self.viewControllers = viewControllers
//        super.init(nibName: nil, bundle: nil)
//
//        self.dataSource = self
//
//        let bar = TMBar.ButtonBar()
//        bar.layout.transitionStyle = .snap
//
//        // Customizing the bar
//        bar.backgroundView.style = .flat(color: .white)
//        bar.indicator.weight = .custom(value: 2)
//        bar.indicator.tintColor = HandySemantic.bgBasicBlack
//        bar.layout.contentMode = .fit
//        bar.buttons.customize { (button) in
//            button.font = HandyFont.B1Sb16
//            button.tintColor = HandySemantic.textBasicTertiary
//            button.selectedTintColor = HandySemantic.bgBasicBlack
//        }
//
//        addBar(bar, dataSource: self, at: .top)
//    }
//
//    public required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override public func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//
//        self.view.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//    }
//
//    // PageboyViewControllerDataSource Methods
//    public func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
//        return viewControllers.count
//    }
//
//    public func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
//        return viewControllers[index]
//    }
//
//    public func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
//        return nil
//    }
//}
//
//
//
//
//import UIKit
//import SnapKit
//import YDS
//import Parchment
//
//class TabBarPageViewController: StoryBookViewController {
//
//    private struct TabBarModel {
//        var type: PagingViewController.TabBarType = .scrollable
//        var numberOfTaps: Int = 8
//    }
//
//    private var tabBarInfo: TabBarModel = TabBarModel()
//
//    private let numberOfTapsArr: [Int] = Array(2...10)
//
//    private let pushButton: YDSBoxButton = {
//        let button = YDSBoxButton()
//        button.size = .large
//        button.rounding = .r8
//        button.type = .filled
//        button.text = "샘플 페이지 보기"
//        return button
//    }()
//
//    private let spacer: UIView = {
//        let view = UIView()
//        view.snp.makeConstraints {
//            $0.height.equalTo(60)
//        }
//        return view
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        addOptions()
//        setupView()
//        registerTapAction()
//    }
//
//    private func setupView() {
//        setLayouts()
//    }
//
//    private func setLayouts() {
//        setViewHierarchy()
//        setAutolayout()
//    }
//
//    private func setViewHierarchy() {
//        self.view.addSubviews(pushButton)
//        stackView.addArrangedSubview(spacer)
//    }
//
//    private func setAutolayout() {
//        pushButton.snp.makeConstraints {
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-32)
//            $0.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16)
//        }
//    }
//
//    private func addOptions() {
//        addOption(description: "TabBarType",
//                  cases: PagingViewController.TabBarType.allCases,
//                  defaultIndex: 0) { [weak self] value in
//            self?.tabBarInfo.type = value
//        }
//
//        addOption(description: "number of tabs",
//                  cases: numberOfTapsArr,
//                  defaultIndex: 2) { [weak self] value in
//            self?.tabBarInfo.numberOfTaps = value
//        }
//    }
//
//    private func registerTapAction() {
//        pushButton.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
//    }
//
//    @objc
//    private func buttonTapAction(_ sender: UIButton) {
//        switch sender {
//        case pushButton:
//            var viewControllers: [UIViewController] = []
//
//            for tap in 0..<tabBarInfo.numberOfTaps {
//                viewControllers.append(ContentViewController(index: tap))
//            }
//
//            let sampleViewController = YDSTabBarViewController(type: tabBarInfo.type, viewControllers: viewControllers)
//            self.navigationController?.pushViewController(sampleViewController, animated: true)
//        default:
//            return
//        }
//    }
//}
//
//extension PagingViewController.TabBarType: CaseIterable {
//    public static var allCases: [PagingViewController.TabBarType] = [.scrollable, .fixed]
//}
//
