//
//  Comment.swift
//  RNDM
//
//  Created by Artur Ratajczak on 30/03/2019.
//  Copyright © 2019 Artur Ratajczak. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    private(set) var username : String!
    private(set) var timestamp : Date!
    private(set) var commentTxt : String!

    
    init(username: String, timestamp: Date, comment: String) {
        self.username = username
        self.timestamp = timestamp
        self.commentTxt = comment
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()
        guard let snap = snapshot else { return comments }
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Unknown username"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let commentTxt = data[COMMENT] as? String ?? ""

            let newComment = Comment(username: username, timestamp: timestamp, comment: commentTxt)
            comments.append(newComment)
        }
        return comments
    }
}
