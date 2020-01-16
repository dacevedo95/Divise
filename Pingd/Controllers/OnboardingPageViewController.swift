//
//  OnboardingPageViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/15/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Properties
    
    weak var onboardingDelegate: OnboardingPageViewControllerDelegate?
    
    var pageHeadings = ["Lorem Ipsum", "Ipsum Lorem", "Ipsum Ipsum"]
    var pageImages = ["FirstOnboardingImage", "FirstOnboardingImage", "FirstOnboardingImage"]
    var pageSubheadings = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod", "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi", "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat"]
    
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set datasource and delegate to itself
        dataSource = self
        delegate = self
        
        // Create First Walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Data Source Functions
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).pageIndex
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! OnboardingContentViewController).pageIndex
        index += 1
        
        return contentViewController(at: index)
    }
    
    // MARK: - Helpers
    func contentViewController(at index: Int) -> OnboardingContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        
        // Create new view controller with data
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(identifier: "OnboardingContentViewController") as? OnboardingContentViewController {
            pageContentViewController.imageFileName = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subheading = pageSubheadings[index]
            pageContentViewController.pageIndex = index
            
            return pageContentViewController
        }
        return nil
    }
    
    // MARK: - Delegate Functions
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? OnboardingContentViewController {
                currentIndex = contentViewController.pageIndex
                onboardingDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
