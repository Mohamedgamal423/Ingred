//
//  RecipeCell.swift
//  ingred
//
//  Created by moh on 1/12/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var Recimage: UIImageView!
    @IBOutlet weak var Categorylbl: UILabel!
    @IBOutlet weak var Recname: UILabel!
    @IBOutlet weak var Rectime: UILabel!
    @IBOutlet weak var Recservings: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        Recimage.layer.cornerRadius = 20
        Recimage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func updateviews(recipe: Recipe) {
        self.Recimage.image = recipe.image
        self.Categorylbl.text = recipe.dishtypes.randomElement()
        self.Recname.text = recipe.name
        self.Rectime.text = "\(recipe.cooktime) minutes"
        self.Recservings.text = String(describing: recipe.servings)
        
    }

}
