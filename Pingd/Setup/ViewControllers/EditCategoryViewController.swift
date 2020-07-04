//
//  EditCategoryViewController.swift
//  Pingd
//
//  Created by David Acevedo on 7/3/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import MSCircularSlider

class EditCategoryViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var categoryIncomeLabel: IncomeLabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var monthlyIncomeLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
        
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            self.confirmButton.layer.cornerRadius = 25.0
        }
    }
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            self.backButton.layer.cornerRadius = 25.0
        }
    }
    
    @IBOutlet weak var circularSlider: MSCircularSlider!
    
    // MARK: - Properties
    var income: CGFloat?
    var percentage: Int?
    
    var monthlyIncomeBeginning = "Monthly income is "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryIncomeLabel.setIncomeLabel(amount: "9999.99", specifiedPointSize: categoryIncomeLabel.font.pointSize)
        
        // Sets the circular slider delegate
        circularSlider.delegate = self
        
        // Attaches the bottom view
        let roundedView = RoundedView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + 44))
        self.bottomView.insertSubview(roundedView, at: 0)
        
        // adds the string
        let monthlyIncome = monthlyIncomeBeginning + "$" + (income ?? 9999.99).description
        let attributedIncomeString = NSMutableAttributedString(string: monthlyIncome, attributes: [NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 14.0)!])
        attributedIncomeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSRange(location: 0, length: 17))
        attributedIncomeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 122, green: 122, blue: 122), range: NSRange(location: 17, length: (monthlyIncome.count - 17)))
        monthlyIncomeLabel.attributedText = attributedIncomeString
        
        // Enables button
        confirmButton.enable()
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

extension EditCategoryViewController: MSCircularSliderDelegate {
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        print("Value changed To: " + round(value).description)
    }
}
