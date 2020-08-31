//
//  SummaryTextViewController.swift
//  Pingd
//
//  Created by David Acevedo on 8/23/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class SummaryTextViewController: SummaryViewController {

    @IBOutlet weak var summaryText: UILabel!
    
    var firstPartText = "You have spent"
    var secondPartText = "this month out of"
    var formattedAmountString = " $%.2f "
    
    var amountSpent: Float?
    var totalAmount: Float?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Builds the first part
        let attrFirstPart = NSMutableAttributedString(string: firstPartText)
        attrFirstPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSMakeRange(0, attrFirstPart.length))
        
        // Builds the second part
        let attrSecondPart = NSMutableAttributedString(string: secondPartText)
        attrSecondPart.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSMakeRange(0, attrSecondPart.length))
        
        // Gets the amount spent
        let attrAmountSpent = NSMutableAttributedString(string: String(format: formattedAmountString, (amountSpent ?? 0.0)))
        let amountColor = (amountSpent ?? 0.0) <= (totalAmount ?? 0.0) ? UIColor(red: 132, green: 214, blue: 184) : UIColor(red: 243, green: 145, blue: 145)
        attrAmountSpent.addAttribute(NSAttributedString.Key.foregroundColor, value: amountColor, range: NSMakeRange(0, attrAmountSpent.length))
        
        // Gets the total amount
        let attrTotalAmount = NSMutableAttributedString(string: String(format: formattedAmountString, (totalAmount ?? 0.0)))
        attrTotalAmount.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 122, green: 122, blue: 122), range: NSMakeRange(0, attrTotalAmount.length))
        
        // Creates the object
        let combination = NSMutableAttributedString()
        combination.append(attrFirstPart)
        combination.append(attrAmountSpent)
        combination.append(attrSecondPart)
        combination.append(attrTotalAmount)
        
        // Sets the line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7.0
        
        // Adds the line spacing
        combination.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, combination.length))
        
        // Adds to the text
        summaryText.attributedText = combination
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
