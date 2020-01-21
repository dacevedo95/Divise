//
//  RegisterViewController.swift
//  Pingd
//
//  Created by David Acevedo on 1/20/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import StepIndicator

class RegisterViewController: UIViewController, RegisterPageViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var stepIndicator: StepIndicatorView!
    @IBOutlet weak var firstButton: UIButton! {
        didSet {
            self.firstButton.layer.cornerRadius = 20.0
        }
    }
    
    // MARK: - Properties
    var registerPageViewController: RegisterPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Delegate Functions
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? RegisterPageViewController {
            registerPageViewController = pageViewController
            registerPageViewController?.registerDelegate = self
        }
    }

    @IBAction func firstButtonPressed(_ sender: Any) {
        if let index = registerPageViewController?.currentIndex {
            switch index {
            case 0...1:
                registerPageViewController?.forwardPage()
            case 2:
                break
            default:
                break
            }
        }
        updateUI()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        if let index = registerPageViewController?.currentIndex {
            switch index {
            case 1...2:
                registerPageViewController?.backwardPage()
            case 0:
                dismiss(animated: false, completion: nil)
            default:
                break
            }
        }
        updateUI()
    }
    
    func updateUI() {
        if let index = registerPageViewController?.currentIndex {
            switch index {
            case 0...1:
                firstButton.setTitle("Next", for: .normal)
            case 2:
                firstButton.setTitle("Create Account", for: .normal)
            default:
                break
            }
            stepIndicator.currentStep = index
        }
        
    }
}
