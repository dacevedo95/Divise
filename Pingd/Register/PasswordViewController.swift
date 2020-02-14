//
//  PasswordViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

class PasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.setUnderLine()
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            self.confirmPasswordTextField.setUnderLine()
        }
    }
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            self.nextButton.layer.cornerRadius = 25.0
        }
    }
    
    
    // MARK: - Properties
    var firstName: String?
    var lastName: String?
    var fieldOneHasText = false
    var fieldTwoHasText = false

    
    // MARK: Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.errorLabel.text = ""
        
        passwordTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    
    // MARK: - Private Functions
    private func showErrorMessage(message: String) {
        self.errorLabel.text = message
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard password != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    func createUser(password: String?) -> Bool {
        return true
    }
    

    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toVerifyScreen" {
            if passwordTextField.text != confirmPasswordTextField.text {
                showErrorMessage(message: "Password fields must match")
                return false
            }
            if !isValidPassword(password: passwordTextField.text!) {
                showErrorMessage(message: "Passwords need at least 8 characters, one capital, one lowercase, and one digit")
                return false
            }

            let userCreated = createUser(password: passwordTextField.text!)
            if !userCreated {
                showErrorMessage(message: "An error occured, please try again later")
                return false
            } else {
                return true
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.errorLabel.text = ""
    }
}

extension PasswordViewController: UITextFieldDelegate {
    
    // MARK: - TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            passwordTextField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        } else {
            performSegue(withIdentifier: "toVerifySegue", sender: self)
        }
        return true
    }
    
    
    // MARK: - Objective C Functions
    @objc func firstTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 0 {
            fieldOneHasText = false
        } else {
            fieldOneHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.nextButton.enable()
        } else {
            self.nextButton.disable()
        }
    }
    
    @objc func secondTextFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 0 {
            fieldTwoHasText = false
        } else {
            fieldTwoHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.nextButton.enable()
        } else {
            self.nextButton.disable()
        }
        
        if !fieldOneHasText {
            showErrorMessage(message: "Password must have 8 characters, and at least one capital, one lowercase, and one number")
        }
    }
}
