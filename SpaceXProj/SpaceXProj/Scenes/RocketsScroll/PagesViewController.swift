//
//  PagesViewController.swift
//  SpaceXProj
//
//  Created by Max on 28.11.2024.
//

import UIKit

class PagesViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private weak var navigation: UINavigationController?
    
    private lazy var pages = [RocketScreen(numberOfPage: 0, navigation: navigation),RocketScreen(numberOfPage: 1, navigation: navigation), RocketScreen(numberOfPage: 2, navigation: navigation), RocketScreen(numberOfPage: 3, navigation: navigation)]
    
    public init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil,
        navigation: UINavigationController
    ) {
        self.navigation = navigation // Сохраняем navigation
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstPage = pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! RocketScreen), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    // Следующая страница
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! RocketScreen), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}
