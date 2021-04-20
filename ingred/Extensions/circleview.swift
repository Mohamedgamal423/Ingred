//
//  circleview.swift
//  ingred
//
//  Created by moh on 4/8/21.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class circleview: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let radius = frame.width / 2
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let radius = frame.width / 2
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
