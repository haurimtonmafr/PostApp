//
//  PostViewModel.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import Foundation

protocol PostDelegate {
    func postDidChange()
    func postMarkedAsFavorite()
    func postUserDidChange()
    func postCommentsDidChange()
}

protocol PostViewModelType {
    
    /* Post object */
    var post: Post {get}
    
    /* View model delegate to notify view and update UI */
    var delegate: PostDelegate? {get set}
    
    /* GET post user */
    func fetchUser()
    
    /* GET post comments */
    func fetchComments()
    
    /* Mark post as favorite */
    func markAsFavorite()
    
}

class PostViewModel: PostViewModelType {
    
    var delegate: PostDelegate?
    
    var post: Post
    
    init(_withPost post: Post) {
        self.post = post
    }
    
    func fetchUser() {
        guard let userId = post.userId else { return }
        APIManager.getUser(_withId: userId, onSuccess: {[weak self] (user) in
            guard let strongSelf = self else { return }
            strongSelf.post.user = user
            strongSelf.delegate?.postUserDidChange()
        }, onFailure: {[weak self] (error) in
            guard let strongSelf = self else { return }
            print("[\(Date())] Get Post(\(strongSelf.post.id ?? 9999)) User Error(\(error.localizedDescription))")
        })
    }
    
    func fetchComments() {
        guard let postId = post.id else { return }
        APIManager.getComments(_forPostId: postId, onSuccess: {[weak self] (comments) in
            guard let strongSelf = self else { return }
            strongSelf.post.comments = comments
            strongSelf.delegate?.postCommentsDidChange()
        }, onFailure: {[weak self] (error) in
            guard let strongSelf = self else { return }
            print("[\(Date())] Get Post(\(strongSelf.post.id ?? 9999)) Comments Error(\(error.localizedDescription))")
        })
    }
    
    func markAsFavorite() {
        if let favorite = post.favorite {
            post.favorite = !favorite
        } else {
            post.favorite = true
        }
        
        delegate?.postMarkedAsFavorite()
    }
    
}
