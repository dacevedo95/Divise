//
//  PasswordViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Alamofire
import os

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
    @IBOutlet weak var buttonWidthConstraint: NSLayoutConstraint!
    
    
    // MARK: - Properties
    var firstName: String?
    var lastName: String?
    var countryCode: UInt64?
    var phoneNumber: UInt64?
    
    var fieldOneHasText = false
    var fieldTwoHasText = false

    
    // MARK: Lifecycle Functions
    override func viewDidLoad() {
        // Initial when the view does load
        super.viewDidLoad()
        self.errorLabel.text = ""
        
        // Sets up listeners on text field
        passwordTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // assigns the textfield to delegate of itself
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        // Logs the variables received when the view does load
        os_log("PasswordViewController loaded with firstName: %s, lastName: %s, countryCode: %s, phoneNumber: %s", log: Log.view, type: .info,
               firstName ?? "no value", lastName ?? "no value", countryCode?.description ?? "no value", phoneNumber?.description ?? "no value")
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
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.errorLabel.text = ""
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        // Logs the entry into the button
        os_log("Create Account Button Pressed", log: Log.view, type: .debug)

        // Creates the user
        createUser(password: passwordTextField.text!)
    }
}

extension PasswordViewController: UITextFieldDelegate {
    
    // MARK: - TextField Delegate Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            passwordTextField.resignFirstResponder()
            confirmPasswordTextField.becomeFirstResponder()
        } else {
            createUser(password: passwordTextField.text!)
        }
        return true
    }

    @objc func firstTextFieldDidChange(_ textField: UITextField) {
        errorLabel.text = ""
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
        errorLabel.text = ""
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

extension PasswordViewController {
    struct NewUser: Encodable {
        let firstName: String
        let lastName: String
        let countryCode: String
        let phoneNumber: String
        let password: String
    }
    
    func createUser(password: String?) {
        // Animates the button
        // self.nextButton.animateWhileAwitingResponse(showLoading: true, originalConstraints: sender.constraints)
        
        // First we check if the password fields match
        if passwordTextField.text != confirmPasswordTextField.text {
            // Logs an error
            os_log("Password fields do no match", log: Log.view, type: .error)
            // Shows the error message
            showErrorMessage(message: "Password fields must match")
            return
        }
        
        // Then we check if the password is valid
        if !isValidPassword(password: passwordTextField.text!) {
            // Logs an error
            os_log("Password does not match criteria", log: Log.view, type: .error)
            // Shows the error message
            showErrorMessage(message: "Passwords need at least 8 characters, one capital, one lowercase, and one digit")
            return
        }
        
        // Creates the initial variables
        let createUserURL = "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/users"
        let user = NewUser(firstName: firstName!, lastName: lastName!, countryCode: String(countryCode!), phoneNumber: String(phoneNumber!), password: password!)
        
        // Starts the signpost
        let signpostID = OSSignpostID(log: Log.networking)
        os_signpost(.begin, log: Log.networking, name: "Create User", signpostID: signpostID, "Creating user")
        
        // Sends the request
        AF.request(createUserURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case let .success(data):
                    // Ends the signpost
                    os_signpost(.end, log: Log.networking, name: "Create User", signpostID: signpostID, "Created user successfully")
                    // Performs the segue and logs it
                    os_log("Performing segue toMainSegue", log: Log.view, type: .info)
                    self.performSegue(withIdentifier: "toMainSegue", sender: self)
                    break
                case let .failure(error):
                    // Logs the error
                    os_signpost(.end, log: Log.networking, name: "Create User", signpostID: signpostID, "Could not create user, error: %s", error.errorDescription ?? "no value")
                    self.showErrorMessage(message: "An error occured. Please try again later")
                    break
                }
            }
    }
}
