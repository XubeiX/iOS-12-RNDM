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
    private(set) var documentId : String!
    private(set) var userId : String!
    
    init(username: String, timestamp: Date, comment: String, documentId:String, userId: String) {
        self.username = username
        self.timestamp = timestamp
        self.commentTxt = comment
        self.documentId = documentId
        self.userId = userId
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()
        guard let snap = snapshot else { return comments }
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Unknown username"
            let timestamp = data[TIMESTAMP] as? Date ?? Date()
            let commentTxt = data[COMMENT] as? String ?? ""
            let documentId = document.documentID
            let userId = data[USER_ID] as? String ?? ""

            let newComment = Comment(username: username, timestamp: timestamp, comment: commentTxt, documentId: documentId, userId: userId)
            comments.append(newComment)
        }
        return comments
    }
}
