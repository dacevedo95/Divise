//
//  MoreInfoPageViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//
import UIKit

protocol MoreInfoPageViewControllerDelegate: class {
    func didUpdatePageIndex(currentIndex: Int)
    func updateBackground(backgroundColor: UIColor)
}

class MoreInfoPageViewController: UIPageViewController {
    
    // MARK: - Properties
    var currentIndex = 0
    weak var moreInfoDelegate: MoreInfoPageViewControllerDelegate?
    
    let backgroundColor: [UIColor] = [#colorLiteral(red: 0.6588235294, green: 0.6352941176, blue: 0.9294117647, alpha: 1), #colorLiteral(red: 0.7568627451, green: 0.6509803922, blue: 0.9333333333, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6745098039, blue: 0.9490196078, alpha: 1)]
    let itemBackgroundColor: [UIColor] = [#colorLiteral(red: 0.7450980392, green: 0.7254901961, blue: 0.9568627451, alpha: 1), #colorLiteral(red: 0.8431372549, green: 0.7450980392, blue: 1, alpha: 1), #colorLiteral(red: 0.7176470588, green: 0.768627451, blue: 0.9764705882, alpha: 1)]
    let icons: [UIImage] = [#imageLiteral(resourceName: "Calendar"), #imageLiteral(resourceName: "ShoppingBag"), #imageLiteral(resourceName: "PiggyBank")]
    let titles: [String] = ["Needs", "Wants", "Savings"]
    let subtitles: [String] = ["The things in your life that are absolutely neccesary", "The things in your life that are nice to have, but not neccesary", "The money left over to invest or pay off any debts"]
    let examples: [[String]] = [
        ["Rent or House Payments", "Groceries", "Utility Bills"],
        ["A New Jacket", "Eating Out at a Restaurant", "Drinks With Friends"],
        ["Stock Purchases", "401k Contributions", "Debt Payments"]
    ]
    let askThisTitles: [String] = ["Not Sure? Ask this:", "Not Sure? Ask this:", "Savings are calculated as follows:"]
    let askThis: [[String?]] = [
        ["Will my life change significantly if I don’t pay this? Yes? Then it’s a need.", nil],
        ["Will my life change significantly if I don’t buy this? No? Then it’s a want.", nil],
        ["Any transactions specified as \"Savings\" (e.g. Stocks, 401k, etc.).", "Any remaining money that wasn't spent during the month."]
    ]
    
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
    }
    
    // MARK: - Helpers
    func contentViewController(at index: Int) -> MoreInfoContentViewController? {
        if index < 0 || index > 2 {
            return nil
        }
        
        // Create new view controller with data
        let storyboard = UIStoryboard(name: "MoreInfo", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(identifier: "MoreInfoContentViewController") as? MoreInfoContentViewController {
            pageContentViewController.pageIndex = index
            
            pageContentViewController.backgroundColor = backgroundColor[index]
            pageContentViewController.categoryIcon = icons[index]
            pageContentViewController.categoryTitle = titles[index]
            pageContentViewController.subcategoryTitle = subtitles[index]
            
            pageContentViewController.itemColorBackground = itemBackgroundColor[index]
            
            pageContentViewController.examples = examples[index]
            
            pageContentViewController.askMoreTitle = askThisTitles[index]
            pageContentViewController.askMoreLabels = askThis[index]
        
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
                moreInfoDelegate?.didUpdatePageIndex(currentIndex: currentIndex)
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
