//
//  SummaryDetailViewController.swift
//  Pingd
//
//  Created by David Acevedo on 8/23/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class SummaryDetailViewController: SummaryViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var amountSpentLabel: UILabel!
    @IBOutlet weak var totalPercentageLabel: UILabel!
    @IBOutlet weak var daysLeftLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    // MARK: - Properties
    var amountSpent: Float?
    var totalAmount: Float?
    var daysLeft: Int?
    var totalPercentage: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountSpentLabel.text = String(format: "$%.2f", amountSpent ?? 0.00)
        totalAmountLabel.text = String(format: "$%.2f", totalAmount ?? 0.00)
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
