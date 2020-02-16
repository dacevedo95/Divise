//
//  LoginViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/18/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Outlets
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
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.errorLabel.text = ""

        // Do any additional setup after loading the view.
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        emailTextField.delegate = self
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
        // Sign in
        print("Signing in")
        if signIn() {
            // Navigate to main screen
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        } else {
            // Display error
            errorLabel.text = "Invalid email or password. Please try again"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVerifySegue" {
            let destinationVC = segue.destination as! PhoneInputViewController
            destinationVC.createUser = false
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
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField.tag == 2 {
            // Sign in
            print("Signing in")
            if signIn() {
                // Navigate to main screen
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: false, completion: nil)
                return true
            } else {
                // Display error
                errorLabel.text = "Invalid email or password. Please try again"
                return false
            }
        }
        
        errorLabel.text = "An error occured. Please try again later"
        return false
    }
}

extension LoginViewController {
    struct Login: Encodable {
        let email: String
        let password: String
    }
    
    
    private func signIn() -> Bool {
        let login = Login(email: emailTextField.text!, password: passwordTextField.text!)
        let signInUrl = "PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/login"
        var loggedIn = false
        
        AF.request(signInUrl, method: .post, parameters: login, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    debugPrint(response)
                    loggedIn = true
                case let .failure(error):
                    debugPrint(error)
                    loggedIn = false
                }
            }
        
        return loggedIn
    }
}
