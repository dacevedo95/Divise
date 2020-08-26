//
//  SummaryTextViewController.swift
//  Pingd
//
//  Created by David Acevedo on 8/23/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class SummaryTextViewController: SummaryViewController {

    @IBOutlet weak var summaryText: UILabel! {
        didSet {
            print("Here")
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 7.0
            
            let attrString = NSMutableAttributedString(string: String(format: text, (amountSpent ?? 0.0), (totalAmount ?? 0.0)))
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            summaryText.attributedText = attrString
        }
    }
    
    var text = "You’ve spent $%.2f this month out of $%.2f"
    var amountSpent: Float?
    var totalAmount: Float?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
