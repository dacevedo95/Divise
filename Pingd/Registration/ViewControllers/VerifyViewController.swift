//
//  VerifyViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import os

class VerifyViewController: UIViewController {

    @IBOutlet weak var codeTextField: CodeTextField!
    @IBOutlet weak var sendAgainButton: UIButton! {
        didSet {
            sendAgainButton.layer.cornerRadius = 25
            sendAgainButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var countryCode: UInt64?
    var phoneNumber: UInt64?
    var formattedNumber: String?
    var createUser: Bool?
    
    var firstName: String?
    var lastName: String?
    
    var userMgmtManager = UserManagementManager()
    
    override func viewDidLoad() {
        // Intial setup
        super.viewDidLoad()
        errorLabel.text = ""

        // Do any additional setup after loading the view.
        descriptionLabel.text! += formattedNumber ?? ""
        
        // Sets up the basic configuartion for the OTP Field
        codeTextField.configure()
        codeTextField.becomeFirstResponder()
        codeTextField.didEnterLastDigit = { [weak self] code in
            self!.verifyCode(code: code)
        }
        codeTextField.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func sendAgainPressed(_ sender: Any) {
        os_log("Send Again Pressed", log: Log.view, type: .debug)
        sendVerification(countryCode: countryCode!.description, phoneNumber: phoneNumber!.description)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        errorLabel.text = ""
        
        if segue.identifier == "changePhoneSegue" {
            let destinationVC = segue.destination as! PhoneInputViewController
            destinationVC.firstName = firstName
            destinationVC.lastName = lastName
            destinationVC.createUser = createUser
        }
        
        if segue.identifier == "toPasswordSegue" {
            let vc = segue.destination as! PasswordViewController
            vc.firstName = firstName
            vc.lastName = lastName
            vc.countryCode = countryCode
            vc.phoneNumber = phoneNumber
        }
    }
}

extension VerifyViewController {
    
    struct VerifyUser: Encodable {
        let countryCode: String
        let phoneNumber: String
        let code: String
    }
    
    struct userExists: Encodable {
        let countryCode: String
        let phoneNumber: String
    }
    
    private func verifyCode(code: String) {
        // Logs entry into the function
        os_log("entered verifyCode", log: Log.view, type: .debug)
        
        // Sets up url and body for the request
        let user = VerifyUser(countryCode: countryCode!.description, phoneNumber: phoneNumber!.description, code: code)
        
        // Performs the request
        userMgmtManager.checkVerification(countryCode: user.countryCode, phoneNumber: user.phoneNumber, code: user.code) { (error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorLabel.text = error
                } else {
                    if self.createUser! {
                        self.performSegue(withIdentifier: "toPasswordSegue", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "toResetPasswordSegue", sender: self)
                    }
                }
            }
        }
    }
    
    private func sendVerification(countryCode: String, phoneNumber: String) {
        // Logs entry into the function
        os_log("in sendVerification", log: Log.view, type: .debug)
        
        // Makes the request
        userMgmtManager.sendVerification(countryCode: countryCode, phoneNumber: phoneNumber) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorLabel.text = error
                }
            }
        }
    }
}

extension VerifyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLabel.text = ""
        return true
    }
}
