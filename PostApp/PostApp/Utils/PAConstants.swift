//
//  PAConstants.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import UIKit

/* Segue to PostsVC identifier */
let kSegueToPostsIdentifier = "SegueToPosts"
/* Segue to PostDetailVC identifier */
let kSegueToPostDetailIdentifier = "SegueToPostDetail"
/* Configure session. */
let kSessionConfig = URLSessionConfiguration.default
/* Create session, and optionally set a URLSessionDelegate. */
let kSession = URLSession(configuration: kSessionConfig, delegate: nil, delegateQueue: nil)
/* Base API URL */
let kBaseURL = "https://jsonplaceholder.typicode.com"
/* API Posts Endpoint */
let kPostsEndpoint = "/posts/"
/* API Users Endpoint */
let kUsersEndpoint = "/users/"
/* API Comments Endpoint */
let kCommentsEndpoint = "/comments/"
/* Posts Persistence Path */
let kPostsArrayKeyPath = "Posts.userDefaults"
/* Unread icon image */
let kUnreadIcon = UIImage(named: "Unread")
/* Favorite icon image */
let kFavoriteIcon = UIImage(named: "Favorite")
/* Description interactive cell identifier */
let kDescriptionInteractiveCellIdentifier = "DescriptionInteractTableViewCell"
