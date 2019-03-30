//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {

    @IBOutlet private weak var usernameLbl: UILabel!
    @IBOutlet private weak var timestampLbl: UILabel!
    @IBOutlet private weak var thoughtTxtLbl: UILabel!
    @IBOutlet private weak var likesNumLbl: UILabel!
    @IBOutlet private weak var likesImg: UIImageView!
    @IBOutlet private weak var commentsNumLbl: UILabel!
    
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImg.isUserInteractionEnabled = true
        likesImg.addGestureRecognizer(tap)
    }
    
    @objc func likeTapped(){
        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId).setData([NUM_LIKES: thought.numLikes + 1], merge: true)
    }

    func configureCell(for thought: Thought) {
        self.thought = thought
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        likesNumLbl.text = String(thought.numLikes)
        commentsNumLbl.text = String(thought.numComments)
        
       
        timestampLbl.text = thought.timestamp.toReadableFormat()
    }

}
