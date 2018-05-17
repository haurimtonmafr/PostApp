//
//  BlueDotIndicatorView.swift
//  PostApp
//
//  Created by Haurimton Andres Martin Franco on 5/16/18.
//  Copyright © 2018 Haurimton Andres Martin Franco. All rights reserved.
//

import UIKit

class BlueDotIndicatorView: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        self.tintColor.setFill()
        context?.fillEllipse(in: rect)
    }
}
