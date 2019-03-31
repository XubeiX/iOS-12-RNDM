//
//  UpdateCommentVC.swift
//  RNDM
//
//  Created by Artur Ratajczak on 31/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentVC: UIViewController {

    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var commentTxt: UITextView!
    
    var commentData: (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTxt.layer.cornerRadius = 10
        updateBtn.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
        commentTxt.text = commentData.comment.commentTxt
    }

    @IBAction func updateBtnWasPressed(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId)
            .collection(COMMENTS_REF).document(commentData.comment.documentId)
            .updateData([COMMENT : commentTxt.text]) { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
