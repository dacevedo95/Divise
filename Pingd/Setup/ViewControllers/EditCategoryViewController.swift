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
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            
            let attrString = NSMutableAttributedString(string: descriptionLabel.text!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            descriptionLabel.attributedText = attrString
            descriptionLabel.textAlignment = .center
        }
    }
    
    // MARK: - Properties
    var income: NSNumber?
    var percentage: Int?
    
    var monthlyIncomeBeginning = "Monthly income is "
    
    var categoryName: String?
    var categoryDescription: String?
    var selectorColor: UIColor?
    
    var currentValue: Double?
    
    var numberFormatter: NumberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryIncomeLabel.setIncomeLabel(amount: "9999.99", specifiedPointSize: categoryIncomeLabel.font.pointSize, isIncomeLabel: false)
        
        // Sets the circular slider delegate
        circularSlider.delegate = self
        
        // Attaches the bottom view
        let roundedView = RoundedView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + 44))
        self.bottomView.insertSubview(roundedView, at: 0)
        
        // adds the string
        // Sets the income label
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        let formattedAmount = numberFormatter.string(from: income ?? 0) ?? ""
        
        let monthlyIncome = monthlyIncomeBeginning + "$" + formattedAmount
        let attributedIncomeString = NSMutableAttributedString(string: monthlyIncome, attributes: [NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 14.0)!])
        attributedIncomeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 198, green: 198, blue: 198), range: NSRange(location: 0, length: 17))
        attributedIncomeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: 122, green: 122, blue: 122), range: NSRange(location: 17, length: (monthlyIncome.count - 17)))
        monthlyIncomeLabel.attributedText = attributedIncomeString
        
        // Enables button
        confirmButton.enable()
        
        // Sets the labels
        categoryLabel.text = categoryName
        descriptionLabel.text = categoryDescription
        
        percentageLabel.text = String(percentage ?? 0)
        currentValue = Double(percentage ?? 20) - 20.0
        circularSlider.currentValue = currentValue!
        circularSlider.filledColor = selectorColor!
        circularSlider.handleColor = selectorColor!
        
        let categoryAmount = NSNumber(value: income!.doubleValue * (Double(percentage!) / 100.0))
        let formattedCategoryAmount = numberFormatter.string(from: categoryAmount)
        categoryIncomeLabel.setIncomeLabel(amount: formattedCategoryAmount ?? "", specifiedPointSize: 36.0, isIncomeLabel: false)
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
        if segue.identifier == "backToCategories" {
            let destinationVC = segue.destination as! CategorySelectorViewController
            destinationVC.income = income
            
            if (sender as! UIButton).tag == 1 {
                if categoryName == "Needs" {
                    destinationVC.needsPercent = Int(currentValue ?? 30.0) + 20
                } else if categoryName == "Wants" {
                    destinationVC.wantsPercent = Int(currentValue ?? 10.0) + 20
                } else {
                    destinationVC.savingsPercent = Int(currentValue ?? 0.0) + 20
                }
            }
        }
    }
    
    @IBAction func confirmUpdate(_ sender: Any) {
        performSegue(withIdentifier: "backToCategories", sender: sender)
    }
    

}

extension EditCategoryViewController: MSCircularSliderDelegate {
    
    func circularSlider(_ slider: MSCircularSlider, valueChangedTo value: Double, fromUser: Bool) {
        if round(value) != round(currentValue!) {
            // Vibrates the device
            UIDevice.vibrate()
            // sets the current value
            currentValue = round(value)
            // sets the label
            percentageLabel.text = (Int(round(currentValue!)) + 20).description
            // sets the text
            let categoryAmount = NSNumber(value: income!.doubleValue * (Double(round(currentValue!) + 20) / 100.0))
            let formattedCategoryAmount = numberFormatter.string(from: categoryAmount)
            categoryIncomeLabel.setIncomeLabel(amount: formattedCategoryAmount ?? "", specifiedPointSize: 36.0, isIncomeLabel: false)
        }
    }
    
    func circularSlider(_ slider: MSCircularSlider, startedTrackingWith value: Double) {
        currentValue = round(value)
    }
}
