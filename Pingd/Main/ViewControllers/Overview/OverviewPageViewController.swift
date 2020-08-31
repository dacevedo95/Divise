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
    
    var overview: OverviewResponse?

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
                summaryTextViewController.amountSpent = overview?.amountSpent
                summaryTextViewController.totalAmount = overview?.monthlyIncome
                return summaryTextViewController
            }
        } else if index == 1 {
            if let summaryDetailViewController = storyboard.instantiateViewController(identifier: "SummaryDetailViewController") as? SummaryDetailViewController {
                summaryDetailViewController.pageIndex = index
                summaryDetailViewController.amountSpent = overview?.amountSpent
                summaryDetailViewController.totalAmount = overview?.monthlyIncome
                summaryDetailViewController.totalPercentage = overview?.totalPercentage
                summaryDetailViewController.daysLeft = overview?.daysLeft
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
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! SummaryViewController).pageIndex
        index += 1
        
        return contentViewController(at: index)
    }
}
