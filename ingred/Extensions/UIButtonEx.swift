//
//  UIViewExtension.swift
//  ingred
//
//  Created by moh on 1/5/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

extension UIButton {
    
    func makegradient(grcolors: [CGColor]) {
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = grcolors
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradient)
        
    }
    
    func defaultsetup() {
        
        layer.cornerRadius = self.layer.frame.height/2
        layer.masksToBounds = true
        let Buttonattributed = NSAttributedString(string: titleLabel!.text!, attributes: [NSAttributedString.Key.kern: 1.5])
        setAttributedTitle(Buttonattributed, for: .normal)
    }
    func makewhitebtn() {
        backgroundColor = .white
        let color = #colorLiteral(red: 1, green: 0.5490196078, blue: 0.168627451, alpha: 1).cgColor
        layer.borderWidth = 2
        layer.borderColor = color
    }
}
