//
//  NewTransactionPageViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/11/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

protocol NewTransactionPageViewControllerDelegate: class {
    func updatePageIndex(currentIndex: Int)
}

class NewTransactionPageViewController: UIPageViewController {
    
    var currentIndex = 0
    weak var newTeansactionDelegate: NewTransactionPageViewControllerDelegate?
    
    let images: [UIImage] = [#imageLiteral(resourceName: "Monthly"), #imageLiteral(resourceName: "Payment")]
    let titles: [String] = ["Monthly Payment", "One Time Payment"]

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Helpers
    func contentViewController(at index: Int) -> NewTransactionContentViewController? {
        if index < 0 || index > 1 {
            return nil
        }
        
        // Create new view controller with data
        let storyboard = UIStoryboard(name: "NewTransaction", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(identifier: "NewTransactionContentViewController") as? NewTransactionContentViewController {
            pageContentViewController.pageIndex = index
            
            pageContentViewController.iconImage = images[index]
            pageContentViewController.titleString = titles[index]
            
            if index == 0 {
                let attrFirstPart = NSMutableAttributedString(string: "Payments that happen once a month. This includes things like ")
                attrFirstPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSMakeRange(0, attrFirstPart.length))
                
                let attrSecondPart = NSMutableAttributedString(string: "Rent, Internet, Streaming Subscriptions,")
                attrSecondPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 153, green: 153, blue: 153), range: NSMakeRange(0, attrSecondPart.length))
                
                let attrThirdPart = NSMutableAttributedString(string: " etc.")
                attrThirdPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSMakeRange(0, attrThirdPart.length))
                
                // Creates the object
                let combination = NSMutableAttributedString()
                combination.append(attrFirstPart)
                combination.append(attrSecondPart)
                combination.append(attrThirdPart)
                
                // Sets the line spacing
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = NSTextAlignment.center
                paragraphStyle.lineSpacing = 5.0
                
                // Adds the line spacing
                combination.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, combination.length))
                pageContentViewController.subtitleString = combination
            } else {
                let attrFirstPart = NSMutableAttributedString(string: "Payments that happen with no pattern of frequency. This includes things like ")
                attrFirstPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSMakeRange(0, attrFirstPart.length))
                
                let attrSecondPart = NSMutableAttributedString(string: "Movie Tickets, Drinks, Takeout,")
                attrSecondPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 153, green: 153, blue: 153), range: NSMakeRange(0, attrSecondPart.length))
                
                let attrThirdPart = NSMutableAttributedString(string: " etc.")
                attrThirdPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSMakeRange(0, attrThirdPart.length))
                
                // Creates the object
                let combination = NSMutableAttributedString()
                combination.append(attrFirstPart)
                combination.append(attrSecondPart)
                combination.append(attrThirdPart)
                
                // Sets the line spacing
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = NSTextAlignment.center
                paragraphStyle.lineSpacing = 5.0
                
                // Adds the line spacing
                combination.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, combination.length))
                pageContentViewController.subtitleString = combination
            }
        
            return pageContentViewController
        }
        return nil
    }

}

extension NewTransactionPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? NewTransactionContentViewController {
                currentIndex = contentViewController.pageIndex
                newTeansactionDelegate?.updatePageIndex(currentIndex: currentIndex)
            }
        }
    }
}

extension NewTransactionPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! NewTransactionContentViewController).pageIndex
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! NewTransactionContentViewController).pageIndex
        index += 1
        
        return contentViewController(at: index)
    }
}
