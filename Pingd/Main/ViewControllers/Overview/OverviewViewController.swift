//
//  MainViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/15/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController, SummaryPageViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var needsImageBackground: UIView! {
        didSet {
            self.needsImageBackground.layer.cornerRadius = self.needsImageBackground.frame.height * 0.2
        }
    }
    @IBOutlet weak var wantsImageBackground: UIView! {
        didSet {
            self.wantsImageBackground.layer.cornerRadius = self.wantsImageBackground.frame.height * 0.2
        }
    }
    @IBOutlet weak var savingsImageBackground: UIView! {
        didSet {
            self.savingsImageBackground.layer.cornerRadius = self.savingsImageBackground.frame.height * 0.2
        }
    }
    
    @IBOutlet weak var headerLabel: UILabel!
    
    // MARK: - Properties
    var overviewPageViewController: OverviewPageViewController?
    
    var userMgmtManager = UserManagementManager()
    
    var overview: OverviewResponse?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the overview
        overview = (parent as! MainTabBarController).overview
        
        // Assign the header
        if let headerText = overview?.header {
            headerLabel.text = headerText
        } else {
            headerLabel.text = "Welcome Back"
        }
    }
    
    func didUpdatePageIndex(currentIndex: Int) {
        if let index = overviewPageViewController?.currentIndex {
            pageControl.currentPage = index
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        if let pageViewController = destination as? OverviewPageViewController {
            overviewPageViewController = pageViewController
            overviewPageViewController?.overview = (parent as! MainTabBarController).overview
            overviewPageViewController?.summaryDelegate = self
        }
    }

}

extension OverviewViewController {
    
}
