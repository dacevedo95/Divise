//
//  PasswordViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Alamofire

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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.errorLabel.text = ""
        
        passwordTextField.addTarget(self, action: #selector(firstTextFieldDidChange), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(secondTextFieldDidChange), for: .editingChanged)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    // MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.errorLabel.text = ""
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        // self.nextButton.animateWhileAwitingResponse(showLoading: true, originalConstraints: sender.constraints)
        
        if passwordTextField.text != confirmPasswordTextField.text {
            showErrorMessage(message: "Password fields must match")
            return
        }
        if !isValidPassword(password: passwordTextField.text!) {
            showErrorMessage(message: "Passwords need at least 8 characters, one capital, one lowercase, and one digit")
            return
        }

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
            if shouldPerformSegue(withIdentifier: "toMainSegue", sender: self){
                performSegue(withIdentifier: "toMainSegue", sender: self)
            }
        }
        return true
    }

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

extension PasswordViewController {
    struct NewUser: Encodable {
        let firstName: String
        let lastName: String
        let countryCode: String
        let phoneNumber: String
        let password: String
    }
    
    func createUser(password: String?) {
        
        let createUserURL = "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/users"
        let user = NewUser(firstName: firstName!, lastName: lastName!, countryCode: String(countryCode!), phoneNumber: String(phoneNumber!), password: password!)
        
        AF.request(createUserURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case let .success(data):
                    debugPrint(data)
                    self.performSegue(withIdentifier: "toMainSegue", sender: self)
                    break
                case let .failure(error):
                    print(error)
                    self.showErrorMessage(message: "An error occured. Please try again later")
                }
            }
    }
}
