//
//  APIManager.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import Foundation

struct APIManager {
    
    static func callService(_withRequest request: URLRequest, completion: @escaping(_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void) {
        kSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
            }.resume()
    }
    
    static func getPosts(onSuccess: @escaping(_ post: [Post]) -> Void, onFailure: @escaping(_ error: Error) -> Void){
        /* Create the Request. */
        guard let url = URL(string: kBaseURL + kPostsEndpoint) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        callService(_withRequest: request) { (data, response, error) in
            if (error == nil) {
                // Success
                do {
                    /**
                     Create decoder
                     */
                    let decoder = JSONDecoder()
                    /**
                     Decode data to object of type Post
                     */
                    var posts = try decoder.decode([Post].self, from: data!)
                    /* Mark first 20 posts as unread */
                    posts = posts.enumerated().map({ var post = $1; post.unread = false; post.favorite = false; if $0 < 20 { post.unread = true; return post } else { return post } })
                    onSuccess(posts)
                } catch let err {
                    onFailure(err)
                }
            }
            else {
                // Failure
                onFailure(error!)
            }
        }
    }
    
    static func getUser(_withId userId: Int, onSuccess: @escaping(_ user: User) -> Void, onFailure: @escaping(_ error: Error) -> Void){
        /* Create the Request. */
        guard let url = URL(string: kBaseURL + kUsersEndpoint + String(userId)) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        callService(_withRequest: request) { (data, response, error) in
            if (error == nil) {
                // Success
                do {
                    /**
                     Create decoder
                     */
                    let decoder = JSONDecoder()
                    /**
                     Decode data to object of type Post
                     */
                    let user = try decoder.decode(User.self, from: data!)
                    onSuccess(user)
                } catch let err {
                    onFailure(err)
                }
            }
            else {
                // Failure
                onFailure(error!)
            }
        }
    }
    
    static func getComments(_forPostId postId: Int, onSuccess: @escaping(_ comments: [Comment]) -> Void, onFailure: @escaping(_ error: Error) -> Void){
        /* Create the Request. */
        guard let url = URL(string: kBaseURL + kCommentsEndpoint + "?postId=\(postId)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        callService(_withRequest: request) { (data, response, error) in
            if (error == nil) {
                // Success
                do {
                    /**
                     Create decoder
                     */
                    let decoder = JSONDecoder()
                    /**
                     Decode data to object of type Post
                     */
                    let comments = try decoder.decode([Comment].self, from: data!)
                    
                    onSuccess(comments)
                } catch let err {
                    onFailure(err)
                }
            }
            else {
                // Failure
                onFailure(error!)
            }
        }
    }
    
}
