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
    
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 25.0
        }
    }
    
    private var incomeString: String = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        incomeLabel.text = "$" + incomeString
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
        
        incomeLabel.text = "$" + incomeString
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
