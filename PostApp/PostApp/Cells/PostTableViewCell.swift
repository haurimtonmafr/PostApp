//
//  PostTableViewCell.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        favoriteIcon.image = nil
        labelTitle.text = nil
    }

}
