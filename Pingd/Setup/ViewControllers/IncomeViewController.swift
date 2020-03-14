//
//  IncomeViewController.swift
//  Pingd
//
//  Created by David Acevedo on 3/14/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

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
    }
    
    @IBAction func keypadPressed(_ sender: UIButton) {
        let tag = sender.tag
    }
    
    private func updateIncomeString() {
        
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
