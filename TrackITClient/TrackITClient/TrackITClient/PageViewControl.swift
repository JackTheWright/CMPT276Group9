//
//  PageViewControl.swift
//  TrackitAddMenu
//
//  Created by Jack Wright on 2018-06-23.
//  Copyright © 2018 Jack Wright. All rights reserved.
//

import UIKit

class PageViewControl: UIPageViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    lazy var ViewControlArray: [UIViewController] = {
        return [self.VCinstance(name:"QuickAdd"),
                self.VCinstance(name:"AdvancedAdd")]
    }()
    
    
    private func VCinstance(name: String) -> UIViewController {
        return UIStoryboard(name: "FoodAdd", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstpage = ViewControlArray.first {
            setViewControllers([firstpage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = ViewControlArray.index(of: viewController) else {
            return nil
        }
        let prevIndex = viewControllerIndex - 1
        guard prevIndex >= 0 else {
            return nil
        }
        guard ViewControlArray.count > prevIndex else {
            return nil
        }
        return ViewControlArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = ViewControlArray.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < ViewControlArray.count else {
            return nil
        }
        guard ViewControlArray.count > nextIndex else {
            return nil
        }
        return ViewControlArray[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return ViewControlArray.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewControllers = viewControllers?.first,
            let firstViewControllerIndex = ViewControlArray.index(of: firstViewControllers) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
}
