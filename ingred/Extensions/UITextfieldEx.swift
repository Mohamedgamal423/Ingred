//
//  UITextfieldEx.swift
//  ingred
//
//  Created by moh on 1/5/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

extension UITextField {
    
    func defaultsetup() {

        let color = #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.borderColor = color.cgColor
        attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
        layer.sublayerTransform = CATransform3DMakeTranslation(12, 0, 0)
    }
}

