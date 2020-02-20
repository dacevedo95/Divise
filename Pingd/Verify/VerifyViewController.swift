//
//  VerifyViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Alamofire
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
        let verifyCodeURL = "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/users/verification/check"
        let user = VerifyUser(countryCode: countryCode!.description, phoneNumber: phoneNumber!.description, code: code)
        
        // Starts the signpost
        let signpostID = OSSignpostID(log: Log.networking)
        os_signpost(.begin, log: Log.networking, name: "Verify Code", signpostID: signpostID, "Starting code verification")
        
        // Performs the request
        AF.request(verifyCodeURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .response { response in
                os_log("Got error %s and status code %d", log: Log.networking, type: .debug, response.error.debugDescription, response.response?.statusCode ?? 0)
                switch response.response?.statusCode {
                case 204:
                    // Logs the failure
                    os_signpost(.end, log: Log.networking, name: "Verify Code", signpostID: signpostID, "Successfully verified code")
                    
                    // Navigate to main screen
                    if self.createUser! {
                        // Go to other page in Register
                        os_log("Performing segue with id toPasswordSegue", log: Log.view, type: .info)
                        self.performSegue(withIdentifier: "toPasswordSegue", sender: self)
                    } else {
                        // Go to reset password
                        os_log("Performing segue with id toResetPasswordSegue", log: Log.view, type: .info)
                        self.performSegue(withIdentifier: "toResetPasswordSegue", sender: self)
                    }
                    break
                case 400:
                    // Logs the failure
                    os_signpost(.end, log: Log.networking, name: "Verify Code", signpostID: signpostID, "Incorrect verification code")
                    // Shows error label
                    self.errorLabel.text = "Incorrect verification code. Please check that the code or phone number is correct"
                    break
                default:
                    // Logs the failure
                    os_signpost(.end, log: Log.networking, name: "Verify Code", signpostID: signpostID, "Error verifying code, status code: %d", response.response?.statusCode ?? 0)
                    // Shows error label
                    self.errorLabel.text = "An error occured. Please try again later"
                    break
                }
            }
    }
    
    private func sendVerification(countryCode: String, phoneNumber: String) {
        // Logs entry into the function
        os_log("in sendVerification", log: Log.view, type: .debug)
        
        // Sets up url and body for the request
        let sendVerificationURL = "http://PingdBackend-dev.us-east-1.elasticbeanstalk.com/api/v1/users/verification"
        let user = userExists(countryCode: countryCode, phoneNumber: phoneNumber)
        
        // Starts the signpost
        let signpostID = OSSignpostID(log: Log.networking)
        os_signpost(.begin, log: Log.networking, name: "Send Verification", signpostID: signpostID, "Sending request with countryCode: %s, phoneNumber %s", user.countryCode, user.phoneNumber)
        
        // Performs the request
        AF.request(sendVerificationURL, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    // Logs the success message
                    os_signpost(.end, log: Log.networking, name: "Send Verification", signpostID: signpostID, "Verification sent successfully")
                    break
                case let .failure(error):
                    // Logs the end of the signpost
                    os_signpost(.end, log: Log.networking, name: "Send Verification", signpostID: signpostID, "Error sending verification: %{public}s", error.localizedDescription)
                    // Sets the error label
                    self.errorLabel.text = "An error occured. Please try again later"
                    break
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
