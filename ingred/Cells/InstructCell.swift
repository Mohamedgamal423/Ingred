//
//  InstructCell.swift
//  ingred
//
//  Created by moh on 1/20/20.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class InstructCell: UITableViewCell {

    @IBOutlet weak var Instructlbl: UILabel!
    @IBOutlet weak var Stepnumb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateview(instruct: String) {
        self.Instructlbl.text = instruct
    }

    

}
