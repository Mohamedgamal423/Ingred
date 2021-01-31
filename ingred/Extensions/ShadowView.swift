//
//  ShadowView.swift
//  ingred
//
//  Created by moh on 1/12/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func draw(_ rect: CGRect) {
        applyshadow()
    }
    func applyshadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 4
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 4, height: 4)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

}
