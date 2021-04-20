//
//  FeaturedCollectionCell.swift
//  ingred
//
//  Created by moh on 1/14/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class FeaturedCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var recimg: UIImageView!
    
    func updateviews(recipe: Recipe) {
        self.recimg.image = recipe.image
        recimg.layer.cornerRadius = 16
    }
}
