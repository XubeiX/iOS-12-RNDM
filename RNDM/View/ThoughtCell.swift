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

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesNumLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    
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
        
        let formater = DateFormatter()
        formater.dateFormat = "d MMM, hh:mm"
        let timestampe = formater.string(from: thought.timestamp)
        timestampLbl.text = timestampe
    }

}
