//
//  RecipeopenCell.swift
//  ingred
//
//  Created by moh on 1/18/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class IngredCell: UITableViewCell {

    @IBOutlet weak var Ingredlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateview(ingred: String) {
        self.Ingredlbl.text = ingred
    }

    

}
