//
//  PostsViewModel.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import Foundation

protocol PostsViewModelDelegate {
    func postsDidChanged()
}

protocol PostsViewModelType {
    
    /* Array that contains all posts objects */
    var posts: [Post] {get}
    
    /* Filter by favorites */
    var filterByFavorites: Bool {get}
    
    /* View model delegate to notify view and update UI */
    var delegate: PostsViewModelDelegate? {get set}
    
    /* Get posts with/without filter */
    func getPosts() -> [Post]
    
    /* Get post at index */
    func getPost(_at index: Int) -> Post
    
    /* GET posts from API */
    func fetchPosts()
    
    /* Set post unread property */
    func setUnread(_ unread: Bool,_forPostId id: Int)
    
    /* Mark/Unmark post as favorite */
    func markPostAsFavorite(_ postId: Int)
    
    /* Delete post with id */
    func deletePost(_withId id: Int)
    
    /* Remove all posts */
    func removeAll()
    
    /* Filter by favorite */
    func filterByFavorite(_ filterFav: Bool)
    
    /* Set user for post with id */
    func setUserForPost(user: User, postId: Int)
    
    /* Set comments for post with id */
    func setCommentsForPost(comments: [Comment], postId: Int)
}

class PostsViewModel: PostsViewModelType {
    var delegate: PostsViewModelDelegate?
    
    var posts: [Post] = [] {
        didSet {
            /* Data Persistence */
            DataManager.savePosts(posts: posts)
            /* Notify posts changed */
            delegate?.postsDidChanged()
        }
    }
    
    var filterByFavorites: Bool = false {
        didSet {
            delegate?.postsDidChanged()
        }
    }
    
    func getPosts() -> [Post] {
        if filterByFavorites {
            return posts.filter({ $0.favorite == true })
        } else {
            return posts
        }
    }
    
    func getPost(_at index: Int) -> Post {
        return getPosts()[index]
    }
    
    func fetchPosts() {
        APIManager.getPosts(onSuccess: {[weak self] (posts) in
            guard let strongSelf = self else { return }
            strongSelf.posts = posts
        }, onFailure: {[weak self] (error) in
            print("[\(Date())] PostsViewModel -> fetchPosts() -> Error(\(error.localizedDescription))")
            guard let strongSelf = self, let posts = DataManager.getPosts() else { return }
            strongSelf.posts = posts
        })
    }
    
    func setUnread(_ unread: Bool, _forPostId id: Int) {
        guard let postIndex = posts.index(where: { $0.id == id }) else { return }
        
        posts[postIndex].unread = unread
    }
    
    func markPostAsFavorite(_ postId: Int) {
        guard let postIndex = posts.index(where: { $0.id == postId }) else {return}
        if let favorite = posts[postIndex].favorite {
            posts[postIndex].favorite = !favorite
        } else {
            posts[postIndex].favorite = true
        }
        
        delegate?.postsDidChanged()
    }
    
    func deletePost(_withId id: Int) {
        guard let postIndex = posts.index(where: { $0.id == id }) else { return }
        
        posts.remove(at: postIndex)
    }
    
    func removeAll() {
        self.posts.removeAll()
    }
    
    func filterByFavorite(_ filterFav: Bool) {
        self.filterByFavorites = filterFav
    }
    
    func setUserForPost(user: User, postId: Int) {
        guard let postIndex = posts.index(where: { $0.id == postId }) else { return }
        
        posts[postIndex].user = user
    }
    
    func setCommentsForPost(comments: [Comment], postId: Int) {
        guard let postIndex = posts.index(where: { $0.id == postId }) else { return }
        
        posts[postIndex].comments = comments
    }
    
}
