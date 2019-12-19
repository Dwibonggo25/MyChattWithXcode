//
//  LoginViewController.swift
//  MyChat
//
//  Created by Dwi Bonggo Pribadi on 12/17/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTexfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTexfield.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password){[weak self] autoResult, error in
                if let e = error {
                    print(e.localizedDescription)
                }else {
                    self?.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
                
            }
        }
       
    }
}
