//
//  LoginViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/18/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Alamofire
import PhoneNumberKit
import os

class LoginViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField! {
        didSet {
            self.phoneNumberTextField.setUnderLine()
            self.phoneNumberTextField.withExamplePlaceholder = true
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
            signInButton.layer.cornerRadius = 25
            signInButton.layer.borderColor = UIColor.lightGray.cgColor
            signInButton.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var createAccountButton: UIButton! {
        didSet {
            self.createAccountButton.layer.cornerRadius = 25
        }
    }
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: - Properties
    var fieldOneHasText = false
    var fieldTwoHasText = false
    
    var phoneNumberKit = PhoneNumberKit()
    var userMgmtManager = UserManagementManager()
    
    var overview: Overview?
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        // Does initial setup
        super.viewDidLoad()
        self.errorLabel.text = ""

        // Do any additional setup after loading the view.
        phoneNumberTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signInPressed(_ sender: Any) {
        // Logs entry into this function
        os_log("Sign in button pressed", log: Log.view, type: .debug)
        // Performs the sign in operation
        signIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Logs entry into the function
        os_log("Preparing for segue with id %{public}s", log: Log.view, type: .info, segue.identifier ?? "no value")
        
        if segue.identifier == "toVerifySegue" {
            // Gets the destination controller
            let destinationVC = segue.destination as! PhoneInputViewController
            // Sets the value of the createUser value
            destinationVC.createUser = false
            // Logs the creation
            os_log("Value createUser sent to PhoneInputViewController with value: %{public}s", log: Log.view, type: .info, false.description)
        }
        
        if segue.identifier == "toMainSegue" {
            // Gets the destination controller
            let destinationVC = segue.destination as! MainTabBarController
            // Sets the value of the createUser value
            destinationVC.overview = self.overview
            print("Overview: " + destinationVC.overview!.header)
        }
        
        errorLabel.text = ""
    }
    
    
    // MARK: Helpers
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

// MARK: UITextField Delegates
extension LoginViewController: UITextFieldDelegate {
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        errorLabel.text = ""
        if textField.text!.count == 0 {
            fieldOneHasText = false
        } else {
            fieldOneHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.signInButton.isEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.signInButton.setTitleColor(UIColor.pingPurple, for: .normal)
                self.signInButton.layer.borderColor = UIColor.pingPurple.cgColor
            }
        } else {
            self.signInButton.isEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.signInButton.setTitleColor(UIColor.lightGray, for: .normal)
                self.signInButton.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        errorLabel.text = ""
        if textField.text!.count == 0 {
            fieldTwoHasText = false
        } else {
            fieldTwoHasText = true
        }
        
        if fieldOneHasText && fieldTwoHasText {
            self.signInButton.isEnabled = true
            UIView.animate(withDuration: 0.2) {
                self.signInButton.setTitleColor(UIColor.pingPurple, for: .normal)
                self.signInButton.layer.borderColor = UIColor.pingPurple.cgColor
            }
        } else {
            self.signInButton.isEnabled = false
            UIView.animate(withDuration: 0.2) {
                self.signInButton.setTitleColor(UIColor.lightGray, for: .normal)
                self.signInButton.layer.borderColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            phoneNumberTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField.tag == 2 {
            signIn()
            return true
        }
        
        errorLabel.text = "An error occured. Please try again later"
        return false
    }
}


// MARK: API Calls
extension LoginViewController {
    struct Login: Encodable {
        let countryCode: String
        let phoneNumber: String
        let password: String
    }
    
    private func signIn() {
        do {
            let nationalNumber = try phoneNumberKit.parse(phoneNumberTextField.text!).nationalNumber
            let countryCode = try phoneNumberKit.parse(phoneNumberTextField.text!).countryCode
            let login = Login(countryCode: String(countryCode), phoneNumber: String(nationalNumber), password: passwordTextField.text!)
            
            userMgmtManager.logIn(countryCode: login.countryCode, phoneNumber: login.phoneNumber, password: login.password) { (error) in
                if let error = error {
                    self.errorLabel.text = error
                    return
                } else {
                    self.userMgmtManager.getOverview { (overview, error) in
                        DispatchQueue.main.async {
                            guard overview != nil else {
                                self.errorLabel.text = error
                                return
                            }
                            
                            self.overview = overview
                            self.performSegue(withIdentifier: "toMainSegue", sender: self)
                        }
                    }
                }
            }
    
        } catch {
            // Signals the end of the error
            os_log("Error while signing in: %{public}s", error.localizedDescription)
            // Show Error could not send verification
            errorLabel.text = "An error occured. Please try again later"
        }
    }
}
