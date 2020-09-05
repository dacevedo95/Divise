//
//  MoreInfoPageViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class MoreInfoPageViewController: UIPageViewController {

    // MARK: - Outlets
    var pageControl = UIPageControl()
    
    // MARK: - Properties
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set datasource and delegate to itself
        delegate = self
        dataSource = self
        
        // Create First Walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
        configurePageControl()
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        pageControl.currentPage = currentIndex
    }
    
    // MARK: - Helpers
    func contentViewController(at index: Int) -> MoreInfoContentViewController? {
        if index < 0 || index >= 2 {
            return nil
        }
        
        // Create new view controller with data
        let storyboard = UIStoryboard(name: "MoreInfo", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(identifier: "MoreInfoContentViewController") as? MoreInfoContentViewController {
            pageContentViewController.pageIndex = index
            print("Here")
            return pageContentViewController
        }
        return nil
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

extension MoreInfoPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? MoreInfoContentViewController {
                currentIndex = contentViewController.pageIndex
                didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}

extension MoreInfoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! MoreInfoContentViewController).pageIndex
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! MoreInfoContentViewController).pageIndex
        index += 1
        
        return contentViewController(at: index)
    }
}
