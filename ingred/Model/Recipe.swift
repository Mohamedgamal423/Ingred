//
//  Recipe.swift
//  ingred
//
//  Created by moh on 1/16/20.
//  Copyright © 2021 moh. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    var name: String
    var cooktime: Int
    var servings: Int
    var image: UIImage?
    var ingredients: [String]
    var instructions: [String]
    
    init(name: String, cooktime: Int, servings: Int, ingredients: [String], method: [String]) {
        self.name = name
        self.cooktime = cooktime
        self.servings = servings
        //self.image = image
        self.ingredients = ingredients
        self.instructions = method
    }
    
}

