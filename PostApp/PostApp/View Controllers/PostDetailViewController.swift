//
//  PostDetailViewController.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var postViewModel: PostViewModelType!
    var postsViewControllerDelegate: PostsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Post"
        let favoriteBarButton = UIBarButtonItem(image: UIImage(named: "Favorite"), style: .done, target: self, action: #selector(self.markPostAsFavorite))
        if (self.postViewModel.post.favorite != nil && self.postViewModel.post.favorite!) {
            favoriteBarButton.tintColor = .yellow
        } else {
            favoriteBarButton.tintColor = .white
        }
        self.navigationItem.rightBarButtonItem = favoriteBarButton
        
        postViewModel.delegate = self
        postViewModel.fetchUser()
        postViewModel.fetchComments()
    }
    
    /* Mark/Unmark post as favorite */
    @objc func markPostAsFavorite() {
        guard let postId = postViewModel.post.id else { return }
        postViewModel.markAsFavorite()
        postsViewControllerDelegate?.markPostAsFavorite(postId)
    }
    
}

// MARK: - Post delegate
extension PostDetailViewController: PostDelegate{
    func postDidChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func postMarkedAsFavorite() {
        DispatchQueue.main.async {
            if (self.postViewModel.post.favorite != nil && self.postViewModel.post.favorite!) {
                self.navigationItem.rightBarButtonItem?.tintColor = .yellow
            } else {
                self.navigationItem.rightBarButtonItem?.tintColor = .white
            }
        }
    }
    
    func postUserDidChange() {
        guard let user = postViewModel.post.user, let postId = postViewModel.post.id else { return }
        postsViewControllerDelegate?.setUserForPost(user: user, postId: postId)
        
        postDidChange()
    }
    
    func postCommentsDidChange() {
        guard let comments = postViewModel.post.comments, let postId = postViewModel.post.id else { return }
        postsViewControllerDelegate?.setCommentsForPost(comments: comments, postId: postId)
        
        postDidChange()
    }
}

// MARK: - TableView DataSource & Delegate
extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if postViewModel.post.user == nil {
            return 1
        } else if postViewModel.post.comments == nil {
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        default:
            return postViewModel.post.comments?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Description"
        case 1:
            return "User"
        default:
            return "Comments"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        guard let postContentCell = tableView.dequeueReusableCell(withIdentifier: kDescriptionInteractiveCellIdentifier, for: indexPath) as? DescriptionInteractiveTableViewCell else { return cell }
        switch indexPath.section {
        case 0:
            postContentCell.descriptionTextView.text = postViewModel.post.body
            
            cell = postContentCell
        case 1:
            switch indexPath.row {
            case 0:
                postContentCell.descriptionTextView.text = postViewModel.post.user?.name
            case 1:
                postContentCell.descriptionTextView.text = postViewModel.post.user?.email
            case 2:
                postContentCell.descriptionTextView.text = postViewModel.post.user?.phone
            default:
                postContentCell.descriptionTextView.text = postViewModel.post.user?.website
            }
            
            cell = postContentCell
        default:
            let userNameString = "\(postViewModel.post.comments?[indexPath.row].name ?? "Unknown"): "
            let attrs = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17.0), NSAttributedStringKey.foregroundColor: UIColor.lightGray]
            let attributedString = NSMutableAttributedString(string: userNameString, attributes:attrs)
            let normalString = NSMutableAttributedString(string: postViewModel.post.comments?[indexPath.row].body ?? "Unknown", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
            
            attributedString.append(normalString)
            
            postContentCell.descriptionTextView.attributedText = attributedString
            
            cell = postContentCell
        }
        
        return cell
    }
    
}
