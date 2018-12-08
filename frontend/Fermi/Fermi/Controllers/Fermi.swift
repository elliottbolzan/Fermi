//
//  Fermi.swift
//  Fermi
//
//  Created by Elliott Bolzan on 12/7/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import UIKit

class Fermi: UIPageViewController {
        
    var pages = [UIViewController]()
    var currentPage = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        let referrals = storyboard!.instantiateViewController(withIdentifier: "referrals")
        let home = storyboard!.instantiateViewController(withIdentifier: "home")
        let profile = storyboard!.instantiateViewController(withIdentifier: "profile")
        pages.append(referrals)
        pages.append(home)
        pages.append(profile)
        setViewControllers([home], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        self.dataSource = self
    }
    
}

extension Fermi: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = pages.index(of: viewController)!
        let previous = index - 1
        if previous < 0 {
            return nil
        }
        return pages[previous]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = pages.index(of: viewController)!
        let next = index + 1
        if next >= pages.count {
            return nil
        }
        return pages[next]
    }
    
}
