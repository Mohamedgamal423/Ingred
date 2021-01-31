//
//  CategoriesCell.swift
//  ingred
//
//  Created by moh on 1/18/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class CategoriesCell: UITableViewCell {

    @IBOutlet weak var Catimg: UIImageView!
    @IBOutlet weak var Catname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    func updateviews(category: Category) {
        self.Catname.text = category.name
        self.Catimg.image = UIImage(named: category.imagename)
    }


}
