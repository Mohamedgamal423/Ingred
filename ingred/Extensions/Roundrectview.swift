//
//  Roundrectview.swift
//  ingred
//
//  Created by moh on 4/19/21.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class Roundrectview: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func setup() {
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    

}
