//
//  IncomeInputViewController.swift
//  Pingd
//
//  Created by David Acevedo on 3/13/20.
//  Copyright © 2020 David Acevedo. All rights reserved.
//

import UIKit
import Hero

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel! {
        didSet {
            self.welcomeLabel.alpha = 0.0
        }
    }
    @IBOutlet weak var toLabel: UILabel! {
        didSet {
            self.toLabel.alpha = 0.0
        }
    }
    @IBOutlet weak var logoImage: UIImageView! {
        didSet {
            self.logoImage.alpha = 0.0
        }
    }
    @IBOutlet weak var logoImageView: UIView! {
        didSet {
            self.logoImageView.hero.id = "logoImageView"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true

        UIView.animate(withDuration: 0.5, animations: {
            self.welcomeLabel.alpha = 1.0
        }) { (animate) in
            UIView.animate(withDuration: 0.5, animations: {
                self.toLabel.alpha = 1.0
            }) { (animate) in
                UIView.animate(withDuration: 1.0, animations: {
                    self.logoImage.alpha = 1.0
                }) { (animate) in
                    UIView.animate(withDuration: 0.0, delay: 4.0, animations: {
                        return
                    }) { (animate) in
                        self.welcomeLabel.heroModifiers = [.fade]
                        self.toLabel.heroModifiers = [.fade]
                        self.performSegue(withIdentifier: "toIncomeScreen", sender: self)
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
