//
//  CreateUserVC.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase

class CreateUserVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.layer.cornerRadius = 4
        passwordTxt.layer.cornerRadius = 4
        usernameTxt.layer.cornerRadius = 4
        createBtn.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createUserBtnWasPressed(_ sender: Any) {
        guard let email = emailTxt.text, let password = passwordTxt.text, let username = usernameTxt.text else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                debugPrint("Error creating user \(error.localizedDescription)")
            } else {
                let changeRequest = authResult?.user.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                    }
                })
                
                guard let userId = authResult?.user.uid else {
                    return
                }
                Firestore.firestore().collection(USERS_REF).document(userId).setData([
                    USERNAME : username,
                    DATE_CREATED: FieldValue.serverTimestamp()
                    ], completion: { (error) in
                        if let err = error {
                            debugPrint(err.localizedDescription)
                        } else {
                            self.dismiss(animated: true, completion: nil)
                        }
                })
            }
        }
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
