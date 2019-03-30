//
//  LoginVC.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet private weak var createUserBtn: UIButton!
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet private weak var emailTxt: UITextField!
    @IBOutlet private weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
        createUserBtn.layer.cornerRadius = 10
        passwordTxt.layer.cornerRadius = 4
        emailTxt.layer.cornerRadius = 4
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnWasPressed(_ sender: Any) {
        guard let email = emailTxt.text, let password = passwordTxt.text else {
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error, let user = authResult?.user {
                debugPrint("Error signIn \(error.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    @IBAction func createUserBtnWasPressed(_ sender: Any) {
    }
}
