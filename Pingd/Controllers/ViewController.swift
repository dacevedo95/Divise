//
//  ViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/12/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    
    @IBOutlet weak var signInWithEmailButton: UIButton!
    @IBOutlet weak var signInWithAppleButton: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view.
        self.setupSignInWithEmail()
        self.setupSignInWithApple()
    }
    
    private func setupSignInWithEmail() {
        signInWithEmailButton.backgroundColor = .clear
        signInWithEmailButton.layer.cornerRadius = 5
        signInWithEmailButton.layer.borderWidth = 1
        signInWithEmailButton.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setupSignInWithApple() {
        // Initiates the button
        let authBtn = ASAuthorizationAppleIDButton()
        print(signInWithAppleButton.frame.size.width)
        // Creates the frame and constraints
        authBtn.frame = CGRect(x: 0, y: 0, width: signInWithAppleButton.frame.size.width, height: signInWithAppleButton.bounds.height)
        // Handles the press
        authBtn.addTarget(self, action: #selector(handleAppleSignin), for: .touchUpInside)
        // Adds the button to the view
        signInWithAppleButton.addSubview(authBtn)
    }
    
    @objc func handleAppleSignin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account as per your requirement
            let appleId = appleIDCredential.user
            let appleUserFirstName = appleIDCredential.fullName?.givenName
            let appleUserLastName = appleIDCredential.fullName?.familyName
            let appleUserEmail = appleIDCredential.email
            //Write your code
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            //Write your code

        }
    }
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

