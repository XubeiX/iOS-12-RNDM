//
//  CommentCell.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit
import Firebase

protocol CommentDelegate {
    func optionsTapped(comment: Comment)
}

class CommentCell: UITableViewCell {

    @IBOutlet private weak var usernameTxt: UILabel!
    @IBOutlet private weak var timestamp: UILabel!
    @IBOutlet private weak var commentTxt: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    private var comment : Comment!
    private var delegate : CommentDelegate?

    func configureCell(for comment: Comment, delegate: CommentDelegate?) {
        self.comment = comment
        self.delegate = delegate
        usernameTxt.text = comment.username
        commentTxt.text = comment.commentTxt
        timestamp.text = comment.timestamp.toReadableFormat()
        
        optionsMenu.isHidden = true
        if comment.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false;
            optionsMenu.isUserInteractionEnabled = true;
            let tap = UITapGestureRecognizer(target: self, action: #selector(optionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func optionsTapped(){
        delegate?.optionsTapped(comment: comment)
    }
    
}
