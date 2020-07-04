//
//  CategorySelectorViewController.swift
//  Pingd
//
//  Created by David Acevedo on 6/30/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class CategorySelectorViewController: UIViewController {

    // MARK: - Bottom Outlets
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var confirmButton: UIButton! {
        didSet {
            self.confirmButton.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var backButton: UIButton!{
        didSet {
            self.backButton.layer.cornerRadius = 25
        }
    }
    
    // MARK: - Top Outlets
    @IBOutlet weak var categoryStaticLabel: UILabel! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            
            let attrString = NSMutableAttributedString(string: categoryStaticLabel.text!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            categoryStaticLabel.attributedText = attrString
        }
    }
    @IBOutlet weak var incomeLabel: UILabel!
    
    // MARK: - Middle Outlets
    @IBOutlet weak var needsBackgroundView: UIView! {
        didSet {
            self.needsBackgroundView.layer.cornerRadius = self.needsBackgroundView.frame.size.height / 6
            
            self.needsBackgroundView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 20, spread: 0)
        }
    }
    @IBOutlet weak var needsRightView: UIView! {
        didSet {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.needsRightView.frame
            rectShape.position = self.needsRightView.center
            
            let radius = self.needsRightView.frame.size.height / 6
            rectShape.path = UIBezierPath(roundedRect: self.needsRightView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
            
            self.needsRightView.layer.backgroundColor = UIColor.white.cgColor
            self.needsRightView.layer.mask = rectShape
        }
    }
    @IBOutlet weak var needsLeftView: UIView! {
        didSet {
            self.needsLeftView.layer.cornerRadius = self.needsLeftView.frame.size.height / 6
        }
    }
    
    @IBOutlet weak var wantsBackgroundView: UIView! {
        didSet {
            self.wantsBackgroundView.layer.cornerRadius = self.needsBackgroundView.frame.size.height / 6
            self.wantsBackgroundView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 20, spread: 0)
        }
    }
    @IBOutlet weak var wantsLeftView: UIView! {
        didSet {
            self.wantsLeftView.layer.cornerRadius = self.wantsLeftView.frame.size.height / 6
        }
    }
    @IBOutlet weak var wantsRightView: UIView! {
        didSet {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.wantsRightView.frame
            rectShape.position = self.wantsRightView.center
            
            let radius = self.wantsRightView.frame.size.height / 6
            rectShape.path = UIBezierPath(roundedRect: self.wantsRightView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
            
            self.wantsRightView.layer.backgroundColor = UIColor.white.cgColor
            self.wantsRightView.layer.mask = rectShape
        }
    }
    
    @IBOutlet weak var savingsBackgroundView: UIView! {
        didSet {
            self.savingsBackgroundView.layer.cornerRadius = self.savingsBackgroundView.frame.size.height / 6
            self.savingsBackgroundView.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 4, blur: 20, spread: 0)
        }
    }
    @IBOutlet weak var savingsLeftView: UIView! {
        didSet {
           self.savingsLeftView.layer.cornerRadius = self.savingsLeftView.frame.size.height / 6
       }
    }
    @IBOutlet weak var savingsRightView: UIView! {
        didSet {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.savingsRightView.frame
            rectShape.position = self.savingsRightView.center
            
            let radius = self.savingsRightView.frame.size.height / 6
            rectShape.path = UIBezierPath(roundedRect: self.savingsRightView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: radius, height: radius)).cgPath
            
            self.savingsRightView.layer.backgroundColor = UIColor.white.cgColor
            self.savingsRightView.layer.mask = rectShape
        }
    }
    
    // MARK: - Buttons
    @IBOutlet weak var needsButton: UIButton! {
        didSet {
            self.needsButton.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 10, spread: 0)
            self.needsButton.layer.cornerRadius = 20.0
        }
    }
    @IBOutlet weak var wantsButton: UIButton! {
        didSet {
            self.wantsButton.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 10, spread: 0)
            self.wantsButton.layer.cornerRadius = 20.0
        }
    }
    @IBOutlet weak var savingsButton: UIButton! {
        didSet {
            self.savingsButton.layer.applySketchShadow(color: .black, alpha: 0.1, x: 0, y: 0, blur: 10, spread: 0)
            self.savingsButton.layer.cornerRadius = 20.0
        }
    }
    
    // MARK: - Percent Labels
    @IBOutlet weak var needsPercentageLabel: UILabel!
    @IBOutlet weak var wantsPercentageLabel: UILabel!
    @IBOutlet weak var savingsPercentageLabel: UILabel!
    
    // MARK: - Properties
    var income: NSNumber?
    
    var needsPercent: Int?
    var wantsPercent: Int?
    var savingsPercent: Int?
    
    var editCategoryInfo: [EditCategoryModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let roundedView = RoundedView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height + 44))
        self.bottomView.insertSubview(roundedView, at: 0)
        
        // Enable confirm button
        confirmButton.enable()
        
        // Sets the labels
        needsPercentageLabel.text = String(needsPercent ?? 50)
        wantsPercentageLabel.text = String(wantsPercent ?? 30)
        savingsPercentageLabel.text = String(savingsPercent ?? 20)
        
        // Sets the income label
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        let formattedAmount = numberFormatter.string(from: income ?? 0)
        incomeLabel.text = "$" + (formattedAmount ?? "")
        
        // Sets the category
        editCategoryInfo.append(EditCategoryModel(name: "Needs", description: "The things in your life that are absolutely neccesary", percentage: needsPercent ?? 50))
        editCategoryInfo.append(EditCategoryModel(name: "Wants", description: "The things in your life that are nice to have, but not neccesary", percentage: wantsPercent ?? 30))
        editCategoryInfo.append(EditCategoryModel(name: "Savings", description: "The money left over to invest or pay off any debts", percentage: savingsPercent ?? 20))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func editCategory(_ sender: Any) {
        performSegue(withIdentifier: "editCategory", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCategory" {
            let destinationVC = segue.destination as! EditCategoryViewController
            let model = editCategoryInfo[(sender as! UIButton).tag]
            
            destinationVC.categoryName = model.name
            destinationVC.categoryDescription = model.description
            destinationVC.percentage = model.percentage
            
            destinationVC.income = income
        }
    }
    
}
