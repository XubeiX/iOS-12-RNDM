//
//  ThoughtCell.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var likesNumLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(for: Thought) {
        
    }

}
