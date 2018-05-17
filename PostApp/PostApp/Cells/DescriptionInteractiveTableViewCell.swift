//
//  DescriptionInteractiveTableViewCell.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import UIKit

class DescriptionInteractiveTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        descriptionTextView.text = nil
        descriptionTextView.font = UIFont.systemFont(ofSize: 17.0)
    }

}
