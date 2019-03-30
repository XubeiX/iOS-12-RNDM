//
//  AddThoughtVC.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var thoughtTxt: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
        thoughtTxt.text = "My random thought..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self
    }
    
    @IBAction func postBtnWasPressed(_ sender: Any) {
        guard let username = usernameTxt.text else {
            return
        }
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES: 0,
            THOUGHT_TXT: thoughtTxt.text!,
            TIMESTAMP: FieldValue.serverTimestamp(),
            USERNAME: username
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func categoryWasChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        thoughtTxt.text = ""
        thoughtTxt.textColor = UIColor.darkGray
    }
}
