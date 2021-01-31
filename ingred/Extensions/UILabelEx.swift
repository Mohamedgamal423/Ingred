//
//  UILabelEx.swift
//  ingred
//
//  Created by moh on 1/5/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setcustomspace(space: CGFloat) {
        attributedText = NSAttributedString(string: self.text!, attributes: [NSAttributedString.Key.kern: space])
    }
}
