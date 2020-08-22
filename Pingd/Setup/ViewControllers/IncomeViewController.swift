//
//  IncomeViewController.swift
//  Pingd
//
//  Created by David Acevedo on 3/14/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

public enum KeyInput: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case dot = "."
    case backspace = ""
}

class IncomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 25.0
        }
    }
    @IBOutlet weak var incomeLabel: IncomeLabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var incomeStaticLabel: UILabel! {
        didSet {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5.0
            
            let attrString = NSMutableAttributedString(string: incomeStaticLabel.text!)
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
            
            incomeStaticLabel.attributedText = attrString
        }
    }
    @IBOutlet weak var logo: UIImageView! {
        didSet {
            self.logo.hero.id = "logoImageView"
        }
    }
    @IBOutlet weak var keypad: UIStackView!
    @IBOutlet weak var buttons: UIStackView!
    
    // MARK: - Properties
    private var incomeString: String = "0"
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        incomeLabel.setIncomeLabel(amount: incomeString, specifiedPointSize: 96.0, isIncomeLabel: true)
        
        let roundedView = RoundedView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: self.view.frame.size.width,
                                                    height: bottomView.frame.size.height + 44))
        
        self.bottomView.insertSubview(roundedView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func keypadPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            updateIncomeString(input: .zero)
        case 1:
            updateIncomeString(input: .one)
        case 2:
            updateIncomeString(input: .two)
        case 3:
            updateIncomeString(input: .three)
        case 4:
            updateIncomeString(input: .four)
        case 5:
            updateIncomeString(input: .five)
        case 6:
            updateIncomeString(input: .six)
        case 7:
            updateIncomeString(input: .seven)
        case 8:
            updateIncomeString(input: .eight)
        case 9:
            updateIncomeString(input: .nine)
        case 99:
            updateIncomeString(input: .dot)
        case 100:
            updateIncomeString(input: .backspace)
        default:
            print("Error")
        }
        
    }
    
    private func updateIncomeString(input: KeyInput) {
        if input == .backspace {
            incomeString.removeLast()
            if incomeString.count < 1 {
                incomeString = "0"
            }
        } else {
            if incomeString == "0" {
                incomeString = input.rawValue
            } else {
                incomeString += input.rawValue
            }
        }
        
        if incomeString.count < 1 {
            incomeString = "0"
        }
        
        print(self.incomeLabel.font.description)
        incomeLabel.setIncomeLabel(amount: incomeString, specifiedPointSize: 96.0, isIncomeLabel: true)
        
        let amount = Double(incomeString)
        if amount != nil {
            if amount! >= 100.00 {
                nextButton.enable()
            } else {
                nextButton.disable()
            }
        } else {
            nextButton.disable()
        }
        
    }
    
    func toAttributedIncomeString(originalString: String) -> NSAttributedString {
        let amountText = NSMutableAttributedString.init(string: originalString)
        amountText.setAttributes([NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 48.0)!,
                                  NSAttributedString.Key.foregroundColor: UIColor.init(red: 203, green: 203, blue: 203),
                                  NSAttributedString.Key.baselineOffset: 25.0], range: NSMakeRange(0, 1))
        return amountText
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
        if segue.identifier == "toCategories" {
            let destinationVC = segue.destination as! CategorySelectorViewController
            destinationVC.income = NumberFormatter().number(from: incomeString)
        }
    }

}
