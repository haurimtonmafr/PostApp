//
//  PostAppTests.swift
//  PostAppTests
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import XCTest
@testable import PostApp

class PostAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetPosts() {
        let promise = expectation(description: "GET posts successful")
        APIManager.getPosts(onSuccess: { (posts) in
            if posts.count == 100 {
                promise.fulfill()
            } else {
                XCTFail("GET \(posts.count) posts")
            }
        }, onFailure: { (error) in
            XCTFail(error.localizedDescription)
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetUserById() {
        let userId = 1
        let promise = expectation(description: "GET post(\(userId)) successful")
        APIManager.getUser(_withId: userId, onSuccess: { (user) in
            if user.name == "Leanne Graham" {
                promise.fulfill()
            } else {
                XCTFail("UserName(\(user.name ?? "Unknown"))")
            }
        }, onFailure: { (error) in
            XCTFail(error.localizedDescription)
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetCommentsByPostId() {
        let postId = 1
        let promise = expectation(description: "GET comments for post(\(postId)) successful")
        APIManager.getComments(_forPostId: postId, onSuccess: { (comments) in
            if comments.count == 5 {
                promise.fulfill()
            } else {
                XCTFail("Comments count(\(comments.count))")
            }
        }, onFailure: { (error) in
            XCTFail(error.localizedDescription)
        })
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
