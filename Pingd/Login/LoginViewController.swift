//
//  LoginViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/18/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.setUnderLine()
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.setUnderLine()
        }
    }
    
    @IBOutlet var signInButton: UIButton! {
        didSet {
            signInButton.backgroundColor = .clear
            signInButton.layer.borderWidth = 1
            signInButton.layer.cornerRadius = 20
            signInButton.layer.borderColor = UIColor.pingPurple.cgColor
            signInButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var createAccountButton: UIButton! {
        didSet {
            self.createAccountButton.layer.cornerRadius = 20
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
