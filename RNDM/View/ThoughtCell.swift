//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase

protocol ThoughtDelegate {
    func optionsTapped(thought: Thought)
}

class ThoughtCell: UITableViewCell {

    @IBOutlet private weak var usernameLbl: UILabel!
    @IBOutlet private weak var timestampLbl: UILabel!
    @IBOutlet private weak var thoughtTxtLbl: UILabel!
    @IBOutlet private weak var likesNumLbl: UILabel!
    @IBOutlet private weak var likesImg: UIImageView!
    @IBOutlet private weak var commentsNumLbl: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    private var thought: Thought!
    private var delegate: ThoughtDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImg.isUserInteractionEnabled = true
        likesImg.addGestureRecognizer(tap)
    }
    
    @objc func likeTapped(){
        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId).setData([NUM_LIKES: thought.numLikes + 1], merge: true)
    }

    func configureCell(for thought: Thought, delegate: ThoughtDelegate?) {
        optionsMenu.isHidden = true
        self.thought = thought
        self.delegate = delegate
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        likesNumLbl.text = String(thought.numLikes)
        commentsNumLbl.text = String(thought.numComments)
        
        timestampLbl.text = thought.timestamp.toReadableFormat()
        
        if thought.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(optionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func optionsTapped(){
        delegate?.optionsTapped(thought: thought)
    }

}
