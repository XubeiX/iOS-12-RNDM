//
//  CommentCell.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet private weak var usernameTxt: UILabel!
    @IBOutlet private weak var timestamp: UILabel!
    @IBOutlet private weak var commentTxt: UILabel!
    

    func configureCell(for comment: Comment) {
        usernameTxt.text = comment.username
        commentTxt.text = comment.commentTxt
        timestamp.text = comment.timestamp.toReadableFormat()
    }
    
}
