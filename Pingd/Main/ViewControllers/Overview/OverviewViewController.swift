//
//  MainViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/15/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import GTProgressBar

class OverviewViewController: UIViewController, SummaryPageViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Needs Outlets
    @IBOutlet weak var needsImageBackground: UIView! {
        didSet {
            self.needsImageBackground.layer.cornerRadius = self.needsImageBackground.frame.height * 0.2
        }
    }
    @IBOutlet weak var needsAmountLabel: UILabel!
    @IBOutlet weak var needsPercentageLabel: UILabel!
    @IBOutlet weak var needsProgressBar: GTProgressBar!
    
    // Wants Outlet
    @IBOutlet weak var wantsImageBackground: UIView! {
        didSet {
            self.wantsImageBackground.layer.cornerRadius = self.wantsImageBackground.frame.height * 0.2
        }
    }
    @IBOutlet weak var wantsAmountLabel: UILabel!
    @IBOutlet weak var wantsPercentageLabel: UILabel!
    @IBOutlet weak var wantsProgressBar: GTProgressBar!
    
    // Savings Outlets
    @IBOutlet weak var savingsImageBackground: UIView! {
        didSet {
            self.savingsImageBackground.layer.cornerRadius = self.savingsImageBackground.frame.height * 0.2
        }
    }
    @IBOutlet weak var savingsAmountLabel: UILabel!
    @IBOutlet weak var savingsPercentageLabel: UILabel!
    @IBOutlet weak var savingsProgressBar: GTProgressBar!
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var whatIsThisButton: UILabel! {
        didSet {
            let buttonTitleStr = NSMutableAttributedString(string:"What is this?")
            buttonTitleStr.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSMakeRange(0, buttonTitleStr.length))
            
            self.whatIsThisButton.attributedText = buttonTitleStr
        }
    }
    
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
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        // Assigns the need
        let needsNumber = NSNumber(value: overview?.settings.needs.spent ?? 0.0)
        let formattedNeedsNumber = numberFormatter.string(from: needsNumber)
        needsAmountLabel.text = "$" + (formattedNeedsNumber ?? "0.00")
        
        let needsPercentage = overview?.settings.needs.percentage ?? 0
        needsPercentageLabel.text = String(format: "%d%%", needsPercentage)
        needsProgressBar.progress = round(CGFloat(Float(needsPercentage) / 100.00) * 100) / 100
        
        // Assigns the wants
        let wantsNumber = NSNumber(value: overview?.settings.wants.spent ?? 0.0)
        let formattedWantsNumber = numberFormatter.string(from: wantsNumber)
        wantsAmountLabel.text = "$" + (formattedWantsNumber ?? "0.00")
        
        let wantsPercentage = overview?.settings.wants.percentage ?? 0
        wantsPercentageLabel.text = String(format: "%d%%", wantsPercentage)
        wantsProgressBar.progress = round(CGFloat(Float(wantsPercentage) / 100.00) * 100) / 100
        
        // Assigns the savings
        let savingsNumber = NSNumber(value: overview?.settings.savings.spent ?? 0.0)
        let formattedSavingsNumber = numberFormatter.string(from: savingsNumber)
        savingsAmountLabel.text = "$" + (formattedSavingsNumber ?? "0.00")
        
        let savingsPercentage = overview?.settings.savings.percentage ?? 0
        savingsPercentageLabel.text = String(format: "%d%%", savingsPercentage)
        savingsProgressBar.progress = round(CGFloat(Float(savingsPercentage) / 100.00) * 100) / 100
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
