//
// File         : PageViewControl.swift
// Module       : TrackITClient
//
// Team Name    : Group 9
// Created By   : Jack Wright
// Created On   : 2018-06-23
//
// Edited By    : Jeremy Schwartz
// Edited On    : 2018-07-03
//  - Updated Header
//

import UIKit

//This class is used for swiping left and right between views in the FoodAdd Storyboard.
class PageViewControl: UIPageViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate {
    
    lazy var ViewControlArray: [UIViewController] = {
        return [self.VCinstance(name:"QuickAdd"),
                self.VCinstance(name:"AdvancedAdd")]
    }()
    
    
    private func VCinstance(name: String) -> UIViewController {
        return UIStoryboard(name: "FoodAdd", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
//  In viewdidLoad() we just set the first page as the first index of the array of views.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        if let firstpage = ViewControlArray.first {
            setViewControllers([firstpage], direction: .forward, animated: true, completion: nil)
        }
    }
    
//  This does all the checks for page positioning, making sure it doesnt exit the bounds when you swipe right on the first page.
    
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
    
// This does the rest of the checks for page positioning, making sure it doesnt go past the array index when swiping left on the last page.
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
    
// Returns the size of the View array.
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return ViewControlArray.count
    }

// Returns index of the View array.
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewControllers = viewControllers?.first,
            let firstViewControllerIndex = ViewControlArray.index(of: firstViewControllers) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
}
