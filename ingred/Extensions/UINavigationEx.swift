//
//  UINavigationEx.swift
//  ingred
//
//  Created by moh on 1/7/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func makenavbarinvisible() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.backIndicatorImage = UIImage()
        navigationBar.backIndicatorTransitionMaskImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    func setNavbarDistance(distance: CGFloat) {
        navigationBar.layer.frame.origin.y = distance
    }
}
