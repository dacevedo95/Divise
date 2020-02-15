//
//  VerifyViewController.swift
//  Pingd
//
//  Created by David Acevedo on 2/2/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""

        // Do any additional setup after loading the view.
        descriptionLabel.text! += formattedNumber ?? ""
        
        codeTextField.configure()
        codeTextField.becomeFirstResponder()
        codeTextField.didEnterLastDigit = { [weak self] code in
            self!.handleVerification(code: code)
        }
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func handleVerification(code: String) {
        if verifyCode(code: code) {
            // Navigate to main screen
            if createUser! {
                if updateUserWithPhone() {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
                    vc.modalPresentationStyle = .fullScreen
                    present(vc, animated: false, completion: nil)
                } else{
                    // Display message an error occured
                }
            } else {
                // Go to reset password
                let vc = UIStoryboard(name: "ResetPassword", bundle: nil).instantiateInitialViewController() as! ResetPasswordViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
            
        } else {
            // Display error
            errorLabel.text = "Incorrect verification code. Please check that the code or phone number is correct"
        }
    }
    
    private func verifyCode(code: String) -> Bool {
        // TODO: Implement Verfification code
        return true
    }
    
    private func updateUserWithPhone() -> Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        errorLabel.text = ""
    }

}
