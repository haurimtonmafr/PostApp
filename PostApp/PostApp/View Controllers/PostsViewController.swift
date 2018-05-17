//
//  PostsViewController.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import UIKit

protocol PostsViewControllerDelegate {
    func markPostAsFavorite(_ postId: Int)
    func setUserForPost(user: User, postId: Int)
    func setCommentsForPost(comments: [Comment], postId: Int)
}

class PostsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var postsViewModel: PostsViewModelType!
    var viewTitle: String!
    var selectedPostIndex: Int!
    var filterPostsByFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewTitle = self.navigationItem.title
        setViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = viewTitle
    }
    
    /* Set view model and get posts */
    func setViewModel() {
        postsViewModel = PostsViewModel()
        postsViewModel.fetchPosts()
        postsViewModel.delegate = self
    }
    
    /* Prepare for SegueToPostDetail */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kSegueToPostDetailIdentifier {
            guard let postDetailVC = segue.destination as? PostDetailViewController, (selectedPostIndex != nil) else {return}

            postDetailVC.postViewModel = PostViewModel(_withPost: postsViewModel.getPost(_at: selectedPostIndex))
            postDetailVC.postsViewControllerDelegate = self
        }
    }
    
    /* Remove all posts */
    @IBAction func deleteAll(_ sender: UIButton) {
        animateRemoveAll {
            self.postsViewModel.removeAll()
            self.setDefaultCellsTransformation(cells: self.tableView.visibleCells)
        }
    }
    
    /* Fetch posts */
    @IBAction func reloadPosts(_ sender: UIBarButtonItem) {
        postsViewModel.fetchPosts()
    }
    
    /* Filter posts by all/favorites */
    @IBAction func filterPostsBy(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            postsViewModel.filterByFavorite(false)
        default:
            postsViewModel.filterByFavorite(true)
        }
    }
    
    /* Set default position for cells array */
    func setDefaultCellsTransformation(cells: [UITableViewCell]) {
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    
    //Method to perform TableView Selection animation, this animation consist on dropping cells to TableView bottom
    func animateRemoveAll(completion: @escaping() -> Void) {
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        setDefaultCellsTransformation(cells: cells)
        
        for (index, cell) in cells.enumerated() {
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight);
            }, completion: { (_) in
                cell.prepareForReuse()
                if index == (cells.count - 1) {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            })
        }
    }
    
}

// MARK: - Posts View Model Delegate
extension PostsViewController: PostsViewModelDelegate {
    func postsDidChanged() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Posts View Controller Delegate
extension PostsViewController: PostsViewControllerDelegate {
    func markPostAsFavorite(_ postId: Int) {
        postsViewModel.markPostAsFavorite(postId)
    }

    func setUserForPost(user: User, postId: Int) {
        postsViewModel.setUserForPost(user: user, postId: postId)
    }
    
    func setCommentsForPost(comments: [Comment], postId: Int) {
        postsViewModel.setCommentsForPost(comments: comments, postId: postId)
    }
    
}

// MARK: - Table DataSource and Delegate
extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.getPosts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let postCell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell {
            let post = postsViewModel.getPosts()[indexPath.row]
            postCell.labelTitle.text = post.title
            if post.unread != nil && post.unread! {
                postCell.favoriteIcon.image = kUnreadIcon
            } else if post.favorite != nil && post.favorite! {
                postCell.favoriteIcon.image = kFavoriteIcon
            }
            
            cell = postCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let postId = postsViewModel.getPost(_at: indexPath.row).id else { return }
        selectedPostIndex = indexPath.row
        performSegue(withIdentifier: "SegueToPostDetail", sender: self)
        self.navigationItem.title = ""
        postsViewModel.setUnread(false, _forPostId: postId)
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let postId = postsViewModel.getPost(_at: indexPath.row).id else { return }
            postsViewModel.deletePost(_withId: postId )
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
