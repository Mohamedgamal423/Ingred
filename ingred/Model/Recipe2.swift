//
//  Recipe2.swift
//  ingred
//
//  Created by moh on 4/10/21.
//  Copyright © 2021 moh. All rights reserved.
//

import UIKit

class Recipe2 {
    var name: String
    var cooktime: Int
    var servings: Int
    var image: UIImage?
    var ingredients: [String]
    var instructions: [String]
    var imurl: String
    
    init(name: String, cooktime: Int, servings: Int, ingredients: [String], method: [String], imur: String) {
        self.name = name
        self.cooktime = cooktime
        self.servings = servings
        //self.image = image
        self.ingredients = ingredients
        self.instructions = method
        self.imurl = imur
    }
    
}
