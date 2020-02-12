//
//  PhoneInputViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/10/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import PhoneNumberKit

class PhoneInputViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var phoneTextField: PhoneNumberTextField! {
        didSet {
            phoneTextField.withExamplePlaceholder = true
        }
    }
    
    @IBOutlet weak var verifyBtn: UIButton! {
        didSet {
            verifyBtn.layer.cornerRadius = 25
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
