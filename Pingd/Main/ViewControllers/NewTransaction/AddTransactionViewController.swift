//
//  AddTransactionViewController.swift
//  Pingd
//
//  Created by David Acevedo on 9/12/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {

    @IBOutlet weak var subtitle: UILabel! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            
            let attrString = NSMutableAttributedString(string: "Record and submit payments so you can track your spending")
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            subtitle.attributedText = attrString
        }
    }
    @IBOutlet weak var addPaymentsButton: UIButton! {
        didSet {
            self.addPaymentsButton.layer.cornerRadius = self.addPaymentsButton.frame.height / 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
