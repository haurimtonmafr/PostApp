//
//  DataManager.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import Foundation

struct DataManager {
    
    static func savePosts(posts: [Post]) {
        let encoder = JSONEncoder()
        do {
            let postsDataEncoded = try encoder.encode(posts)
            let postData = NSKeyedArchiver.archivedData(withRootObject: postsDataEncoded)
            UserDefaults.standard.set(postData, forKey: kPostsArrayKeyPath)
        } catch let err {
            print("[\(Date())] DataManager -> savePosts() -> Error(\(err.localizedDescription))")
        }
    }
    
    static func getPosts() -> [Post]? {
        guard let postsData = UserDefaults.standard.data(forKey: kPostsArrayKeyPath) else { return nil }
        let decoder = JSONDecoder()
        do {
            let posts = try decoder.decode([Post].self, from: NSKeyedUnarchiver.unarchiveObject(with: postsData) as! Data)
            
            return posts
        } catch let err {
            print("DataManager -> getPosts() -> Error(\(err))")
            
            return nil
        }
    }
    
}
