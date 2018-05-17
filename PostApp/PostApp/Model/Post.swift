//
//  Post.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let body: String?
    var favorite: Bool?
    let id: Int?
    let title: String?
    var unread: Bool?
    let userId: Int?
    var user: User?
    var comments: [Comment]?
    
}
