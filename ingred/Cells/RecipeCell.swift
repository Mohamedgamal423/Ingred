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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func updateviews(recipe: Recipe) {
        self.Recimage.image = recipe.image
        self.Categorylbl.text = "Food"
        self.Recname.text = recipe.name
        self.Rectime.text = String(describing: recipe.cooktime)
        self.Recservings.text = String(describing: recipe.servings)
    }

}
