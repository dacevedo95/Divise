//
//  SummaryDetailViewController.swift
//  Pingd
//
//  Created by David Acevedo on 8/23/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import GTProgressBar

class SummaryDetailViewController: SummaryViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var amountSpentLabel: UILabel!
    @IBOutlet weak var totalPercentageLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var progressBar: GTProgressBar!
    
    // MARK: - Properties
    var amountSpent: Float?
    var totalAmount: Float?
    var daysLeft: Int?
    var totalPercentage: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Formatter
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        // set up amount spent
        let amountSpentNumber = NSNumber(value: amountSpent ?? 0.00)
        let formattedSpentNumber = numberFormatter.string(from: amountSpentNumber)
        amountSpentLabel.text = "$" + (formattedSpentNumber ?? "0.00")
        
        // set up total amount
        let totalAmountNumber = NSNumber(value: totalAmount ?? 0.00)
        let formattedTotalAmount = numberFormatter.string(from: totalAmountNumber)
        totalAmountLabel.text = "$" + (formattedTotalAmount ?? "0.00")
        
        // total percentage label
        totalPercentageLabel.text = String(format: "%d%%", totalPercentage ?? 0)
        
        // sets the progress bar
        progressBar.progress = round(CGFloat(Float((totalPercentage ?? 0)) / 100.00) * 100) / 100
        
        // days left
        let attrFirstPart = NSMutableAttributedString(string: String(format: "%d ", daysLeft ?? 0))
        attrFirstPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 122, green: 122, blue: 122), range: NSMakeRange(0, attrFirstPart.length))
        
        let daysLeftText = (daysLeft ?? 0) > 1 ? "days left" : "day left"
        let attrSecondPart = NSMutableAttributedString(string: daysLeftText)
        attrSecondPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSMakeRange(0, attrSecondPart.length))
        
        let combination = NSMutableAttributedString()
        combination.append(attrFirstPart)
        combination.append(attrSecondPart)
        
        daysLeftLabel.attributedText = combination
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
