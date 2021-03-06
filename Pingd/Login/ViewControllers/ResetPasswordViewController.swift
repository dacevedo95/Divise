//
//  ResetPasswordViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/15/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import os

class ResetPasswordViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var newPasswordLabel: UITextField! {
        didSet {
            self.newPasswordLabel.setUnderLine()
        }
    }
    @IBOutlet weak var confirmNewPasswordLabel: UITextField! {
        didSet {
            self.confirmNewPasswordLabel.setUnderLine()
        }
    }
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton! {
        didSet{
            self.resetButton.layer.cornerRadius = 25.0
        }
    }
    
    
    // MARK: - Properties
    var fieldOneHasText = false
    var fieldTwoHasText = false
    
    var userMgmtManager = UserManagementManager()
    
    var countryCode: UInt64?
    var phoneNumber: UInt64?
    
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorLabel.text = ""
        
        newPasswordLabel.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        confirmNewPasswordLabel.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        newPasswordLabel.delegate = self
        confirmNewPasswordLabel.delegate = self
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
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func updatePassword(password: String) -> Bool {
        return true
    }
    
    @IBAction func resetPasswordPressed(_ sender: Any) {
        // Logs entry into this function
        os_log("Sign in button pressed", log: Log.view, type: .debug)
        // Performs the reset password operation
        resetPassword()
    }
    

    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toLoginSegue" {
            if newPasswordLabel.text != confirmNewPasswordLabel.text {
                showErrorMessage(message: "Password fields must match")
                return false
            }
            if !isValidPassword(password: newPasswordLabel.text!) {
                showErrorMessage(message: "Passwords need at least 8 characters, one capital, one lowercase, and one digit")
                return false
            }

            let passwordUpdated = updatePassword(password: newPasswordLabel.text!)
            if !passwordUpdated {
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

extension ResetPasswordViewController: UITextFieldDelegate {
    
    // MARK: - TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            newPasswordLabel.resignFirstResponder()
            confirmNewPasswordLabel.becomeFirstResponder()
        } else if textField.tag == 2 {
            resetPassword()
            return true
        }
        
        errorLabel.text = "An error occured. Please try again later"
        return false
    }

    @objc func firstTextFieldDidChange(_ textField: UITextField) {
        errorLabel.text = ""
        if textField.text!.count == 0 {
            fieldOneHasText = false
        } else {
            fieldOneHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.resetButton.enable()
        } else {
            self.resetButton.disable()
        }
    }
    
    @objc func secondTextFieldDidChange(_ textField: UITextField) {
        errorLabel.text = ""
        if textField.text!.count == 0 {
            fieldTwoHasText = false
        } else {
            fieldTwoHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.resetButton.enable()
        } else {
            self.resetButton.disable()
        }
        
        if !fieldOneHasText {
            showErrorMessage(message: "Password must have 8 characters, and at least one capital, one lowercase, and one number")
        }
    }
}

extension ResetPasswordViewController {
    struct ResetPasswordModel: Encodable {
        let countryCode: String
        let phoneNumber: String
        let newPassword: String
    }
    
    private func resetPassword() {
        let newPassword = newPasswordLabel.text
        
        userMgmtManager.resetPassword(countryCode: String(countryCode!), phoneNumber: String(phoneNumber!), newPassword: newPassword!) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorLabel.text = error
                    return
                } else {
                    self.performSegue(withIdentifier: "toLoginSegue", sender: self)
                }
            }
        }
    }
}
