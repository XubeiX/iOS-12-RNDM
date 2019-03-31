//
//  LoginVC.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LoginVC: UIViewController, GIDSignInUIDelegate {

    @IBOutlet private weak var createUserBtn: UIButton!
    @IBOutlet private weak var loginBtn: UIButton!
    @IBOutlet private weak var emailTxt: UITextField!
    @IBOutlet private weak var passwordTxt: UITextField!
    
    @IBOutlet weak var facebookLoginBtn: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 10
        createUserBtn.layer.cornerRadius = 10
        passwordTxt.layer.cornerRadius = 4
        emailTxt.layer.cornerRadius = 4
        
        GIDSignIn.sharedInstance()?.uiDelegate = self
        
        facebookLoginBtn.delegate = self
        facebookLoginBtn.readPermissions = ["email"]
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
    

    @IBAction func googleSignInWasPressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error, let user = authResult?.user {
                debugPrint(error.localizedDescription)
                return
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func funcfacebookLoginBtnWasPressed(_ sender: Any) {
        
    }
}

extension LoginVC: FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            debugPrint("Facebook error \(error.localizedDescription)")
            return
        }
  
        guard  let token = result.token?.tokenString else {
            return
        }
        
        let credential =  FacebookAuthProvider.credential(withAccessToken: token)
        firebaseLogin(credential)
     
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
}
