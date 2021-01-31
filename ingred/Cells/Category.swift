//
//  Category.swift
//  ingred
//
//  Created by moh on 1/19/20.
//  Copyright © 2021 moh. All rights reserved.
//

import Foundation

struct Category {
    
    private (set) public var name: String
    private (set) public var imagename: String
    
    init(name: String, imagename: String) {
        self.name = name
        self.imagename = imagename
    }
   
    
}
