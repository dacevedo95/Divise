//
//  OverviewPageViewController.swift
//  Pingd
//
//  Created by David Acevedo on 8/22/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

protocol SummaryPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
}

class OverviewPageViewController: UIPageViewController {

    // MARK: - Properties
    
    weak var summaryDelegate: SummaryPageViewControllerDelegate?
    
    var currentIndex = 0
    
    var amountSpent: Float?
    var totalAmount: Float?
    var daysLeft: Int?
    var percentageSpent: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set datasource and delegate to itself
        delegate = self
        dataSource = self
        
        // Create First Walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // MARK: - Helpers
    func contentViewController(at index: Int) -> SummaryViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if index == 0 {
            if let summaryTextViewController = storyboard.instantiateViewController(identifier: "SummaryTextViewController") as? SummaryTextViewController {
                summaryTextViewController.pageIndex = index
                summaryTextViewController.amountSpent = amountSpent
                summaryTextViewController.totalAmount = totalAmount
                return summaryTextViewController
            }
        } else if index == 1 {
            if let summaryDetailViewController = storyboard.instantiateViewController(identifier: "SummaryDetailViewController") as? SummaryDetailViewController {
                summaryDetailViewController.pageIndex = index
                return summaryDetailViewController
            }
        } else {
            return nil
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

extension OverviewPageViewController : UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? SummaryViewController {
                currentIndex = contentViewController.pageIndex
                summaryDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}

extension OverviewPageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SummaryViewController).pageIndex
        index -= 1
        print("New Before Index: " + index.description)
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SummaryViewController).pageIndex
        index += 1
        print("New After Index: " + index.description)
        return contentViewController(at: index)
    }
}
