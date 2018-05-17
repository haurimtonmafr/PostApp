//
//  LaunchScreenViewController.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sloganContainerView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Animate author label and sloganContainerView
        UIView.animate(withDuration: 0.6, animations: {
            self.authorLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.sloganContainerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { (_) in
            self.performSegue(withIdentifier: kSegueToPostsIdentifier, sender: self)
        })
    }

}
