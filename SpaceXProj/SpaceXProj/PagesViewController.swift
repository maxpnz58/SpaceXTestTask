//
//  PagesViewController.swift
//  SpaceXProj
//
//  Created by Max on 28.11.2024.
//

import UIKit

class PagesViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    let pages = [SpaceXInitialScreen(numberOfPage: 0),SpaceXInitialScreen(numberOfPage: 1), SpaceXInitialScreen(numberOfPage: 2), SpaceXInitialScreen(numberOfPage: 3)]
    
    public override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
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
        guard let index = pages.firstIndex(of: viewController as! SpaceXInitialScreen), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    // Следующая страница
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController as! SpaceXInitialScreen), index < pages.count - 1 else {
            return nil
        }
        return pages[index + 1]
    }
}
